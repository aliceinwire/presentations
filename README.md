# presentations

Public presentations for conferences.

## How to build locally

The root `Makefile` builds every presentation folder that contains a Markdown file:

```bash
make        # builds HTML and PDF outputs for all presentations
make clean  # removes generated HTML and PDF files
```

You can still run `make` inside an individual presentation directory to work on a single deck; each folder uses the shared `presentation.mk` rules.

## LPC 2026

`LPC_2026_TALK/` contains the 15-minute kci-dev talk and timed speaker notes.
Build it with `make -C LPC_2026_TALK` (requires Marp CLI and a supported browser).
The Markdown comments contain the speaker notes. Reference and rehearsal
details are in `LPC_2026_TALK/notes/`.
