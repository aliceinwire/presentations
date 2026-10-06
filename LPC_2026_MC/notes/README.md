# LPC 2026 references and examples

**Title:** kci-dev: What Changed, What Works, and What Kernel Developers Still Need

**Speaker:** Arisu Tachibana

The deck introduces the work since LPC 2025, the reusable Python interface,
and two example plugins: `kci-patchwork` and `kci_release_review`. It includes
captured results, their interpretation and proposals for further work.
Speaker notes appear in the Marp comments, HTML presenter view and
[SPEAKER_NOTES.md](SPEAKER_NOTES.md).

Small, faint superscript numbers link the relevant phrases to their sources.
Numbers restart on each slide and remain clickable in HTML and PDF. Hover or
keyboard focus makes them clearer without showing a URL tooltip. The speaker
notes retain detailed source lists.

## Source snapshots

Sources were inspected on 6 October 2026.

- kci-dev main: `e4c00874f1bcfbd6a6f1cdd513320b2e95713a42`.
- kci-patchwork: [`1acedb7ab59a2bf8ab9934c4cf76727552c04b10`](https://github.com/aliceinwire/kci-patchwork/tree/1acedb7ab59a2bf8ab9934c4cf76727552c04b10).
- kci_release_review: `b328d0a60e46a1c7062d36b2d062d0fcac7ac442`.
- Both plugin dependency files pin kci-dev to
  `ba6b7134f1296702182b6559b5a2320f3d6b40fa`.

The kci-patchwork source links were rechecked after its repository was recreated.
The pinned files support the workflow descriptions in the slides. The captured
results below are retained unchanged.

The public Python client and patchset examples exist in v0.1.11. The structured
comparison and gate examples refer to the inspected main snapshot. Its version
string is also 0.1.11, so use the commit hash to distinguish it from the release
tag. The plugins are standalone Python applications, without a registration
requirement in the kci-dev command-line tool.

## Captured results

- [Patchwork run excerpt](evidence/patchwork-series-1178390.json): the supplied
  staging command for CIP series 1178390 and its JSON result. It demonstrates
  submission and result collection with jobs still active. No completed build
  comparison is claimed from that capture. Local report paths retain the
  redactions in the supplied output.
- [Completed CIP evidence](evidence/patchwork-series-1178390-completed.json):
  read-only recovery on 6 October of the submitted patchset and its two build
  descendants, all `done/pass`. The stored patch artifact matches the Patchwork
  diff byte for byte. Replaying public API snapshots through the pinned plugin
  collector gives two matched passing builds, but `EVIDENCE_INCOMPLETE` for the
  broader baseline comparison. The original local run directory was unavailable;
  the saved excerpt distinguishes reconstructed metadata from observed nodes.
- [Conflicting-result evidence](evidence/patchset-conflicting-results-2026-10-05.json):
  the supplied tinyconfig smoke-test warning, stored results and exit code, with
  a reproduction of the state classifier at the recorded client revision. This
  smoke test is separate from the CIP Patchwork run and remains `NOT_VERIFIED`.
- [Release-review evidence](evidence/release-review-2026-10-05.json): selected
  fields from published reports collected on 5 October 2026. It retains source
  URLs, exact commit selections, assessment, counts, observations, history
  information and the displayed regression candidate. Other comparison entries
  and supplemental evidence are omitted from this excerpt.
- `../images/release-review-counts.png`: a screenshot of the six count cards in
  the published linux-6.6.y report. It uses the saved report HTML without altering
  its values or styling. The slide remains readable without contacting the site.

The public report site can update. The evidence files preserve the observations
used by the slides. Counts are classifications of executions, rather than
confirmed kernel defects. Required coverage and release approval are separate
from those observations.

[Walkthrough instructions](PATCHWORK_WALKTHROUGH.md) describe the recorded
sequence and the recovered result. The [captured HTML snapshot](../examples/patchwork-series-1178390/report.html)
opens the completed build evidence and its comparison summary without making
API requests. It is published alongside the slides, with its JSON excerpt.

## Using the examples

The CIP submission command is a recorded staging example. Choose a suitable
checkout and supported jobs before adapting it. Use `status` or `watch` with
the saved run directory to continue collection. The slides do not require
starting another submission.

General code snippets expect caller-supplied repository, branch, commit hashes,
client configuration or selected patch data. `selection` in the report example
contains `origin`, `giturl`, `branch`, `base` and `head`. Public Dashboard reads
do not need a submission token. Triggering pipeline jobs and submitting external
builds require the corresponding configured endpoints and credentials.

The priority order and proposed shared-interface contract are discussion
proposals. Source links accompany each slide's notes.

## Conference and build

[Official contribution](https://lpc.events/event/20/contributions/2534/)

The deck keeps the repository's pink palette and JetBrains Mono font. From the
repository root, run `make -C LPC_2026_MC` with Marp CLI and a supported browser.
The root `make` also discovers this deck. Notes live one level deeper so the
build does not treat them as slide decks.
