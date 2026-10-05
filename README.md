# presentations

Public presentations for conferences.

## How to build locally

The root `Makefile` builds decks in presentation folders containing a `Makefile`,
both at the repository root and inside year folders. Speaker notes are excluded.

```bash
make        # builds HTML and PDF outputs for all presentations
make clean  # removes generated HTML and PDF files
make list   # lists the Markdown decks used by the build and deployment
```

You can still run `make` inside an individual presentation directory to work on a single deck; each folder uses the shared `presentation.mk` rules.
Both build paths use `.marprc.yml`, which enables the local SVG diagrams needed
for PDF export. Marp CLI and a supported browser must be installed.

## LPC 2026

`LPC_2026_MC/` contains the kci-dev presentation for the Kernel Testing &
Dependability MC, with speaker notes and approximate rehearsal timings.
Build it with `make -C LPC_2026_MC`.
The Markdown comments contain the speaker notes. Reference and rehearsal
details are in `LPC_2026_MC/notes/`.

## 2025 archive

- `2025/OSSJ_2025/`
- `2025/LPC_2025_TALK/`
- `2025/LPC_2025_MC/`

For example, run `make -C 2025/OSSJ_2025` to build the OSS Japan deck.
