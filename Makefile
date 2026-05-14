SHELL        := /bin/bash
PUBLIC_PRINT := public_print
PUBLIC       := public
PDF_DIR      := build/playwright

.PHONY: build hugo-print hugo-build pdf pdf-all clean

build: hugo-print pdf-all

hugo-print:
	hugo --config hugo.toml,hugo.print.toml --destination $(PUBLIC_PRINT)

pdf: hugo-print
	@test -n "$(CONTENT)" || (echo "Usage: make pdf CONTENT=<section/slug>"; exit 1)
	mkdir -p $(PDF_DIR)
	python3 scripts/playwright-pdf.py \
	    "file://$(CURDIR)/$(PUBLIC_PRINT)/$(CONTENT)/index.html" \
	    "$(PDF_DIR)/$(subst /,-,$(CONTENT)).pdf"
	@echo "Written: $(PDF_DIR)/$(subst /,-,$(CONTENT)).pdf"

DOC_SECTIONS := datasheets product-announcements reports user-manuals

pdf-all: hugo-print
	mkdir -p $(PDF_DIR)
	@find $(addprefix $(PUBLIC_PRINT)/,$(DOC_SECTIONS)) -mindepth 2 -name 'index.html' | sort | while read f; do \
	    rel="$${f#$(PUBLIC_PRINT)/}"; rel="$${rel%/index.html}"; \
	    slug="$${rel//\//-}"; \
	    echo "  $$rel → $$slug.pdf"; \
	    python3 scripts/playwright-pdf.py \
	        "file://$(CURDIR)/$$f" \
	        "$(PDF_DIR)/$$slug.pdf"; \
	done

hugo-build:
	hugo --config hugo.toml

clean:
	rm -rf $(PUBLIC_PRINT) $(PDF_DIR)
