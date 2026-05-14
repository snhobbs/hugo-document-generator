# Hugo Document Generator

## Purpose

This project is focused on co-generating PDFs and HTML for product documentation.
The PDF generation is aimed at using Chromium.
The brand colors, logos, and meta data are defined in a yaml file. The brand itself is a hugo module allowing simple swapping of branding for different uses.

## Use

This is a normal Hugo project. Content is added to the corresponding directory. Playwright + chromium is used in the makefile to export the pdfs.
