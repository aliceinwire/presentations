# Recorded Patchwork walkthrough

Use the existing CIP series 1178390 recording and the
[captured result snapshot](../examples/patchwork-series-1178390/report.html).
The walkthrough requires no new submission. The earlier tinyconfig debugging
story is a separate experiment.

## Present the sequence

1. Open [series 1178390](https://patchwork.kernel.org/series/1178390/): version 3,
   one patch, “PCI: rzg3s-host: Fix compilation warning”.
2. Show the recorded staging command in the deck. Point out the explicit base
   checkout and `kbuild-gcc-14-arm64-510-cip` job selection.
3. Show the original `RUNNING` excerpt. It had two observed nodes and no completed
   baseline comparison. A `pass` counter alone did not identify a finished build.
4. Explain how `status` and `watch` continue the same saved run. If the original
   directory is available, these commands refresh its reports:

   ```sh
   RUN=runs/patchwork.kernel.org/series-1178390
   kci-patchwork status --run "$RUN"
   kci-patchwork watch --run "$RUN"
   xdg-open "$RUN/report.html"
   ```

5. Open the committed snapshot. Show the three terminal passing nodes, then the
   two baseline/patched build pairs. The kselftest child compiles test binaries;
   it does not demonstrate execution of those tests.
6. Ask whether the series can be approved from that evidence. Show the actual
   `EVIDENCE_INCOMPLETE` comparison: 3,699 missing, 9 ambiguous and 15 incomplete
   entries alongside the two unchanged passes. The baseline included runtime
   work absent from this build-only submission.
7. Finish with the coverage question: which jobs and platforms must this
   particular review exercise? The report retains `required_coverage=not_assessed`
   and `approved=false`.

The first two commands can return a nonzero status while successfully writing a
report. In the captured completed-run replay the collector returns exit `2` for
incomplete comparison evidence. Inspect the report to interpret the outcome.

## How the final evidence was recovered

The original local `manifest.json`, `state.json` and reports were unavailable.
The completed evidence is explicitly a read-only reconstruction on 6 October
2026, not a later capture of the original local invocation.

- The recorded checkout `6ab272040ed308c6c2d206c3` has a patchset child
  `6ac44ef33a60498f8d8ab085`, created on 6 October at 01:29:23 UTC, with the recorded
  ARM64 CIP job filter.
- Its `patch0` artifact is byte-identical to patch 14863610 in series 1178390:
  573 bytes, SHA-256
  `8240cab525488a49021afeaacccb5a496aedc7ff466219afbccfac5188c19c98`.
- The calculated pipeline patchset hash matches the submitted root and build
  metadata. Parent checkout, source revision and job/platform filters match.
- The patched tree listing contains three nodes, all `done/pass`. The root,
  kernel build and kselftest compilation have a complete parent chain.
- Reconstructed local observation metadata and the saved API responses were
  passed through the unmodified `collect()` implementation at plugin commit
  `1acedb7ab59a2bf8ab9934c4cf76727552c04b10`. Its client adapter exposes only
  `get_node` and `get_nodes` reads; no submission method is provided.
- The baseline query used the recorded tree ID and selected job path, with
  pages of 1,000 nodes. Returned page sizes were 1,000, 1,000, 1,000 and 739.
  The collector produced 3,725 comparison entries with the counts shown above.

The committed JSON is an excerpt: it retains the complete submitted-tree node
set, comparison summary and five selected comparison rows, omitting unrelated
node metadata and the other baseline rows. The HTML snapshot renders that
excerpt; it is not the plugin's original HTML report.

## Sources

- [Original running capture](evidence/patchwork-series-1178390.json)
- [Completed evidence and query provenance](evidence/patchwork-series-1178390-completed.json)
- [Recorded smoke-test conflict and source reproduction](evidence/patchset-conflicting-results-2026-10-05.json)
- [Collector](https://github.com/aliceinwire/kci-patchwork/blob/1acedb7ab59a2bf8ab9934c4cf76727552c04b10/kci_patchwork/results.py)
- [Comparison rules](https://github.com/aliceinwire/kci-patchwork/blob/1acedb7ab59a2bf8ab9934c4cf76727552c04b10/kci_patchwork/comparison.py)
- [Patch identity checks](https://github.com/aliceinwire/kci-patchwork/blob/1acedb7ab59a2bf8ab9934c4cf76727552c04b10/kci_patchwork/workflow.py#L194-L237)
