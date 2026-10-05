MARPDOC ?= $(firstword $(wildcard *.md))
MARP ?= marp
MARP_FLAGS ?=
MARP_CONFIG := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/.marprc.yml)
THEME ?= $(firstword $(wildcard *.css))
BASE_NAME := $(basename $(notdir $(MARPDOC)))
PDF_OUT ?= $(BASE_NAME).pdf
HTML_OUT ?= $(BASE_NAME).html

MARP_THEME_ARG := $(if $(THEME),--theme-set $(THEME))

all: html pdf

pdf:
	@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
	$(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) $(MARPDOC) $(MARP_THEME_ARG) --pdf -o $(PDF_OUT)

html:
	@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
	$(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) $(MARPDOC) $(MARP_THEME_ARG) --html -o $(HTML_OUT)

watch:
	@if [ -z "$(MARPDOC)" ]; then echo "No markdown file found to build"; exit 1; fi
	$(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) $(MARPDOC) $(MARP_THEME_ARG) --html --watch --server

clean:
	rm -f $(PDF_OUT) $(HTML_OUT)

.PHONY: all pdf html watch clean
