PRESENTATION_MD := $(wildcard */*.md)
HTML_OUTPUTS := $(PRESENTATION_MD:.md=.html)
PDF_OUTPUTS := $(PRESENTATION_MD:.md=.pdf)

all: $(HTML_OUTPUTS) $(PDF_OUTPUTS)

%.html: %.md
	@theme_file="$(firstword $(wildcard $(dir $<)*.css))"; \
	if [ -z "$$theme_file" ]; then \
	  marp "$<" --html -o "$@"; \
	else \
	  marp "$<" --theme-set "$$theme_file" --html -o "$@"; \
	fi

%.pdf: %.md
	@theme_file="$(firstword $(wildcard $(dir $<)*.css))"; \
	if [ -z "$$theme_file" ]; then \
	  marp "$<" --pdf -o "$@"; \
	else \
	  marp "$<" --theme-set "$$theme_file" --pdf -o "$@"; \
	fi

clean:
	rm -f $(HTML_OUTPUTS) $(PDF_OUTPUTS)

.PHONY: all clean
