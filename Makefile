MARP ?= marp
MARP_FLAGS ?=
MARP_CONFIG := $(abspath .marprc.yml)
PRESENTATION_DIRS := $(patsubst %/Makefile,%,$(wildcard */Makefile [0-9][0-9][0-9][0-9]/*/Makefile))
PRESENTATION_MD := $(sort $(foreach dir,$(PRESENTATION_DIRS),$(wildcard $(dir)/*.md)))
HTML_OUTPUTS := $(PRESENTATION_MD:.md=.html)
PDF_OUTPUTS := $(PRESENTATION_MD:.md=.pdf)

all: $(HTML_OUTPUTS) $(PDF_OUTPUTS)

%.html: %.md .marprc.yml Makefile
	@theme_file="$(firstword $(wildcard $(dir $<)*.css))"; \
	if [ -z "$$theme_file" ]; then \
	  $(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) "$<" --html -o "$@"; \
	else \
	  $(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) "$<" --theme-set "$$theme_file" --html -o "$@"; \
	fi

%.pdf: %.md .marprc.yml Makefile
	@theme_file="$(firstword $(wildcard $(dir $<)*.css))"; \
	if [ -z "$$theme_file" ]; then \
	  $(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) "$<" --pdf -o "$@"; \
	else \
	  $(MARP) --config-file "$(MARP_CONFIG)" $(MARP_FLAGS) "$<" --theme-set "$$theme_file" --pdf -o "$@"; \
	fi

clean:
	rm -f $(HTML_OUTPUTS) $(PDF_OUTPUTS)

list:
	@printf '%s\n' $(PRESENTATION_MD)

.PHONY: all clean list
