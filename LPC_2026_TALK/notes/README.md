# LPC 2026 rehearsal and references

**Title:** kci-dev: What Changed, What Works, and What Kernel Developers Still Need

**Speaker:** Arisu Tachibana

**Format:** 12 slides, 15 minutes of prepared remarks, followed by discussion.
The script is about 1,600 words. Allow time to point out the commands and pause
on the comparison and gate tables. Rehearse with a timer and adjust to your pace.
Speaker notes also appear in the Marp Markdown comments and HTML presenter view.

## Timing

| Slide | Topic | Time |
| --- | --- | --- |
| 1 | Introduction | 00:00-00:40 |
| 2 | Maintainer question | 00:40-01:45 |
| 3 | Changes since LPC 2025 | 01:45-03:05 |
| 4 | Python interface | 03:05-04:25 |
| 5 | Patch submission | 04:25-05:55 |
| 6 | Revision comparison | 05:55-07:25 |
| 7 | Classification semantics | 07:25-08:55 |
| 8 | Gate policy and coverage | 08:55-10:15 |
| 9 | Service consistency | 10:15-11:30 |
| 10 | Experimental MCP interface | 11:30-12:40 |
| 11 | Proposed priorities | 12:40-14:05 |
| 12 | Discussion questions | 14:05-15:00 |

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
The comparison limitations on slide 9 describe this source snapshot and should
be refreshed if they are fixed before presenting.

## Examples

The snippets explain the interfaces. They do not contain captured live test
results. Supply a real Git URL, branch and full commit hashes for the comparison
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
time and duration. This deck follows the requested 15-minute speaking time
and intentionally omits a scheduled start time. Confirm the final slot with
the MC schedule before presenting.

## Theme and build

The theme carries forward the repository's pink palette and JetBrains Mono
font. It omits the old embedded background because that artwork contains
LPC 2025's Tokyo date and venue. The original decks remain unchanged.

From the repository root, run `make -C LPC_2026_TALK` with Marp CLI and a
supported browser installed. The root `make` also discovers this deck. Notes
live one level deeper so the existing build does not treat them as slide decks.
