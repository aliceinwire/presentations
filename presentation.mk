MARPDOC ?= $(firstword $(wildcard *.md))
THEME ?= $(firstword $(wildcard *.css))
BASE_NAME := $(basename $(notdir $(MARPDOC)))
PDF_OUT ?= $(BASE_NAME).pdf
HTML_OUT ?= $(BASE_NAME).html

MARP_THEME_ARG := $(if $(THEME),--theme-set $(THEME))

all: html pdf

pdf:
@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
marp $(MARPDOC) $(MARP_THEME_ARG) --pdf -o $(PDF_OUT)

html:
@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
marp $(MARPDOC) $(MARP_THEME_ARG) --html -o $(HTML_OUT)

watch:
@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
marp $(MARPDOC) $(MARP_THEME_ARG) --html --watch --server

clean:
rm -f $(PDF_OUT) $(HTML_OUT)

.PHONY: all pdf html watch clean
