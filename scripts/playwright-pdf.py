#!/usr/bin/env python3
"""Convert a local HTML file to PDF using Playwright + Chromium."""
import sys
import threading
import http.server
from pathlib import Path
from playwright.sync_api import sync_playwright


def find_web_root(html_path: Path) -> Path:
    """Walk up from html_path to find the static output root (dir containing logos/ or icons/)."""
    d = html_path.parent
    while d != d.parent:
        if (d / "logos").is_dir() or (d / "icons").is_dir():
            return d
        d = d.parent
    return html_path.parent


def start_server(root: Path):
    class QuietHandler(http.server.SimpleHTTPRequestHandler):
        def __init__(self, *args, **kwargs):
            super().__init__(*args, directory=str(root), **kwargs)

        def log_message(self, *args):
            pass

    httpd = http.server.HTTPServer(("127.0.0.1", 0), QuietHandler)
    t = threading.Thread(target=httpd.serve_forever, daemon=True)
    t.start()
    return httpd.server_address[1], httpd


def html_to_pdf(input_url: str, output: str) -> None:
    httpd = None
    if input_url.startswith("file://"):
        html_path = Path(input_url[7:])
        root = find_web_root(html_path)
        rel = html_path.relative_to(root)
        port, httpd = start_server(root)
        url = f"http://127.0.0.1:{port}/{rel}"
    else:
        url = input_url

    try:
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            page.goto(url, wait_until="networkidle")
            page.pdf(path=output, print_background=True)
            browser.close()
    finally:
        if httpd:
            httpd.shutdown()


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <file-url-or-http-url> <output.pdf>", file=sys.stderr)
        sys.exit(1)
    html_to_pdf(sys.argv[1], sys.argv[2])
