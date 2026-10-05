# LPC 2026 rehearsal and references

**Title:** kci-dev: What Changed, What Works, and What Kernel Developers Still Need

**Speaker:** Arisu Tachibana

**Format:** 13 slides, about 16 minutes at the suggested pace, followed by discussion.
The timings are rehearsal guidance. Allow time to point out the commands and pause
on the comparison and gate tables. Rehearse with a timer and adjust to your pace.
Speaker notes also appear in the Marp Markdown comments and HTML presenter view.

## Timing

| Slide | Topic | Time |
| --- | --- | --- |
| 1 | Introduction | 00:00-00:40 |
| 2 | Work since LPC 2025 | 00:40-01:40 |
| 3 | Maintainer question | 01:40-02:45 |
| 4 | Changes and versions | 02:45-04:05 |
| 5 | Python interface | 04:05-05:25 |
| 6 | Patch submission | 05:25-06:55 |
| 7 | Revision comparison | 06:55-08:25 |
| 8 | Classification semantics | 08:25-09:55 |
| 9 | Gate policy and coverage | 09:55-11:15 |
| 10 | Service consistency | 11:15-12:30 |
| 11 | Experimental MCP interface | 12:30-13:40 |
| 12 | Proposed priorities | 13:40-15:05 |
| 13 | Discussion questions | 15:05-16:00 |

## Versions

The research snapshot is 4 October 2026.

- Presentations repository base: `8653ff4d41ad3854f666aecec43d043a6400f33c`.
- kci-dev v0.1.11: `2113a3bc1fccb2fa9f719b1ca98442a4e96fc945`.
- kci-dev main: `e4c00874f1bcfbd6a6f1cdd513320b2e95713a42`.

The Python client and patchset examples exist in v0.1.11. The six-category
comparison report, `--format` option and `results gate` example use the main
snapshot above. The version string in main still says 0.1.11, so use the commit
hash to distinguish these examples from the release tag. Earlier releases already
had a `results compare` command with a different implementation.

The priority order and proposed ownership split are discussion proposals.
The comparison limitations on slide 10 describe this source snapshot and should
be refreshed if they are fixed before presenting.

## Examples

The snippets explain the interfaces. They do not contain captured live test
results. End-to-end patchset validation for this talk is still pending.
Supply a real Git URL, branch and full commit hashes for the comparison
examples. The Python example expects `GIT_URL`, `BRANCH` and `COMMIT` from its
caller. Patchset submission needs a configured pipeline/token, an existing
checkout node, local patches and supported job/test selections. Public Dashboard
queries do not need a submission token. KCIDB submission and storage have their
own configured endpoints and credentials.

The prepared talk does not require a live demo. Source links accompany each
slide in [SPEAKER_NOTES.md](SPEAKER_NOTES.md).

## Conference listing

[Official contribution](https://lpc.events/event/20/contributions/2534/)

[Detailed timetable](https://lpc.events/event/20/timetable/?view=standard)

At retrieval, the contribution page and timetable disagreed on the scheduled
time and duration. The timings are approximate, and the deck
intentionally omits a scheduled start time. Confirm the final slot with
the MC schedule before presenting.

## Theme and build

The theme carries forward the repository's pink palette and JetBrains Mono
font. It omits the old embedded background because that artwork contains
LPC 2025's Tokyo date and venue. The original decks remain unchanged.

From the repository root, run `make -C LPC_2026_TALK` with Marp CLI and a
supported browser installed. The root `make` also discovers this deck. Notes
live one level deeper so the existing build does not treat them as slide decks.
