# presentations

Public presentations for conferences.

## How to build locally

The root `Makefile` builds every presentation folder that contains a Markdown file:

```bash
make        # builds HTML and PDF outputs for all presentations
make clean  # removes generated HTML and PDF files
```

You can still run `make` inside an individual presentation directory to work on a single deck; each folder uses the shared `presentation.mk` rules.
