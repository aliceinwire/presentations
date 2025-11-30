MARPDOC = OSSJ_2025_kernelci-cli.md
THEME   = gyaru.css
PDF_OUT = OSSJ_2025_kernelci-cli.pdf
HTML_OUT = OSSJ_2025_kernelci-cli.html

all: html pdf

pdf:
	marp $(MARPDOC) --theme-set $(THEME) --pdf -o $(PDF_OUT)

html:
	marp $(MARPDOC) --theme-set $(THEME) --html -o $(HTML_OUT)

watch:
	marp $(MARPDOC) --theme-set $(THEME) --html --watch --server

clean:
	rm -f $(PDF_OUT) $(HTML_OUT)

.PHONY: all pdf html watch clean
