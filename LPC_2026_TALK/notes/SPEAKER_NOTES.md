# LPC 2026 speaker notes

kci-dev: What Changed, What Works, and What Kernel Developers Still Need

Arisu Tachibana

Suggested pace: about 16 minutes. Discussion follows.

## 1. kci-dev

00:00-00:40 (40 seconds)

I created kci-dev to make KernelCI useful directly in a kernel developer's workflow, and I continue to lead the project. At last year's LPC, we discussed closing that feedback loop. Today I want to show what we can do now, where the interfaces still fall short, and which workflow we should finish together. I will start with the work since last year, then leave room for discussion.

Sources:
https://lpc.events/event/20/contributions/2534/
https://github.com/aliceinwire/presentations/blob/8653ff4d41ad3854f666aecec43d043a6400f33c/LPC_2025_TALK/LPC_2025_TALK.md

## 2. Our work since LPC 2025

00:40-01:40 (60 seconds)

kci-dev connects kernel developers' tools to KernelCI. Since last year's LPC, our work has focused on making that connection reliable and easier to use.

We fixed cases where watching a job or running a bisection could hang. Rejected retries now report failure, validation checks that result identifiers match, and JSON output gives scripts one readable result document.

The reusable Python API lets other tools call kci-dev directly. External build reporting brings results from other build systems into KernelCI, while the patchset interface accepts patches against a known base. The interface is implemented; we still need a successful end-to-end run to validate the complete patch submission workflow for this talk.

Sources:
https://github.com/kernelci/kci-dev/pull/290
https://github.com/kernelci/kci-dev/pull/301
https://github.com/kernelci/kci-dev/pull/288
https://github.com/kernelci/kci-dev/pull/294
https://github.com/kernelci/kci-dev/pull/295
https://github.com/kernelci/kci-dev/pull/277
https://github.com/kernelci/kci-dev/pull/266
https://github.com/kernelci/kci-dev/pull/287

## 3. A maintainer's question

01:40-02:45 (65 seconds)

Imagine you are reviewing a patch series or preparing a stable update. You have a baseline and a candidate. KernelCI has results, but the decision still needs context. A failure count alone does not tell you whether the candidate introduced a problem. A different board, compiler or configuration can change what you are comparing. A missing test can also make the candidate look better than it really is.

The useful question is what changed for this kernel, under comparable conditions, and what should the maintainer investigate next. That is the workflow I want kci-dev to support. We already have several of the operations we need. The remaining work is to connect them with explicit expectations about evidence and coverage.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/README.md
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/libs/regression.py

## 4. What changed since LPC 2025

02:45-04:05 (80 seconds)

Last year's slides included a reusable library as a priority. By v0.1.11 we had a public Python client, alongside the command-line interface. That lets another application call kci-dev and work with Python objects. External build systems can also construct and submit KCIDB build results, with separate storage commands for their artifacts.

Patchset submission is another concrete step. We can submit local patch files or allowed patch URLs against an existing checkout. Validation, job watching and bisection have also received attention, together with packaging and machine-readable reports.

There is an important version distinction here. The structured comparison and gate examples later in this talk use current main, beyond the v0.1.11 tag. The optional MCP server exists in the release, but its interface remains experimental. These are different levels of availability, so a workflow should pin the version it actually uses.

Sources:
https://github.com/kernelci/kci-dev/tree/v0.1.11
https://github.com/kernelci/kci-dev/compare/v0.1.11...e4c00874f1bcfbd6a6f1cdd513320b2e95713a42
https://github.com/kernelci/kci-dev/blob/v0.1.11/docs/patchset.md
https://github.com/kernelci/kci-dev/blob/v0.1.11/kcidev/subcommands/storage.py
https://github.com/kernelci/kci-dev/blob/v0.1.11/docs/mcp.md

## 5. A reusable Python interface

04:05-05:25 (80 seconds)

This is the small integration example I want people to take away. The caller supplies a repository URL, branch and full commit hash. The public client makes the Dashboard request and returns the result as Python data. Public Dashboard queries do not require a KernelCI submission token.

That gives a patch review service or release report a direct interface. It can keep the result in its own workflow and handle recoverable failures through KciDevError. It does not need to parse terminal tables. For an external build system, submit_build constructs and submits a build result using configured KCIDB credentials. It reports a build that the caller has already performed.

The boundary matters. kci-dev provides the client operations. The integrating application still owns its trigger policy, credentials and decision about what a result means. GIT_URL, BRANCH and COMMIT here are values supplied by that application.

Sources:
https://github.com/kernelci/kci-dev/blob/v0.1.11/README.md#using-kci-dev-as-a-python-library
https://github.com/kernelci/kci-dev/blob/v0.1.11/kcidev/api.py

## 6. Patches on a known base

05:25-06:55 (90 seconds)

The patchset interface is implemented; end-to-end validation for this talk is still pending. First, create a checkout of the intended base revision using the checkout command. Its checkout_nodeid becomes CHECKOUT_NODE here. Then submit the patches in their intended order and select jobs that are available on that pipeline. The watch option can wait for the named test.

There are two submission forms. Local text patches go through patch, while patchurl sends URLs from a domain the pipeline permits. That includes Patchwork mbox URLs. A request uses one form or the other. The documented inline limits are thirty-two patches, up to ten mebibytes each, and binary patches are not supported.

This is useful, but the surrounding review workflow still needs work. Someone must track the series version and its base, choose the jobs, preserve the resulting identifiers, and connect the results back to the review. That distinction changes our roadmap: the next contribution can build on an existing operation.

Sources:
https://github.com/kernelci/kci-dev/blob/v0.1.11/docs/patchset.md
https://github.com/kernelci/kci-dev/blob/v0.1.11/kcidev/subcommands/patchset.py

## 7. Comparing two revisions

06:55-08:25 (90 seconds)

Now we have results for a baseline and a candidate. Current main can compare the two explicit commit hashes and return a structured report. I use explicit hashes here because a review needs to remain tied to the revisions we intended to compare. The default latest-two-checkouts mode is convenient for exploration, but its inputs can change as new results arrive.

The implementation groups results by their execution identity. That includes the origin, platform, architecture, compiler, configuration and test path, with builds, boots and tests handled separately. It preserves repeated results instead of simply overwriting them.

The report carries the two commits, category counts and individual result identifiers, plus an incomplete flag. Optional known-issue lookup adds requests, so it has a cost. This gives another program useful evidence to inspect. It still depends on the quality of the metadata and the scope of the results returned by the backend.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/docs/results.md
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/api.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/libs/regression.py

## 8. What the report tells us

08:25-09:55 (90 seconds)

Here is how to read those categories. A pass becoming a fail or error can produce a regression. A failure becoming a pass can produce a fix. Failures on both sides are persistent. Results found on only one side become new or missing. History can refine the classification and mark a test unstable.

We need to be careful with that unstable label. The code also uses it for other status changes, so it does not by itself establish that a test is flaky. Similarly, the classifier groups FAIL and ERROR together. A lab problem can therefore produce a signal that still needs investigation before we attribute it to the patch.

My proposal is to preserve the underlying statuses, identifiers and history, then make the next action explicit: inspect the logs, retry under comparable conditions, or investigate infrastructure. Maintainers need enough evidence to check the classification and decide what should happen next.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/libs/regression.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/tests/test_regression.py

## 9. Gate policy and coverage

09:55-11:15 (80 seconds)

The gate command makes part of that policy executable. In this example I choose to fail on regressions and missing results. The default selects regression only. A policy violation returns one, while an incomplete comparison returns two. Command usage errors can also return two, so an integration should keep the report and diagnostic output.

Zero means that no selected category triggered the policy. It does not establish that all the tests a maintainer expected actually ran. For example, if neither revision contains an expected test, a comparison cannot discover that expectation on its own. Missing only identifies an absence relative to the other side.

For release review, I want a separate statement of required coverage: which configurations, platforms and tests must finish, and how recent the evidence must be. That is a proposed workflow contract beyond the current category-based gate.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/subcommands/results/__init__.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/libs/regression.py

## 10. Reliability across services

11:15-12:30 (75 seconds)

KernelCI has several service boundaries. A job in Maestro and a result in the Dashboard need consistent identities and statuses. The maestro validate commands already help compare build and boot records, including missing identifiers and status mismatches. That gives us a way to investigate the data path as well as the kernel.

Two concrete limitations remain in the current comparison path. It fetches branch history, and the classifier applies matching history identities without checking that the history belongs to the requested candidate. Historical comparisons need stronger scoping. Also, the compare and gate commands construct a default client without passing the CLI configuration. That can send a configured workflow to the production Dashboard instead.

These are fixable interface problems. A review should keep its endpoint and revisions explicit, and the report should preserve the evidence needed to reproduce its conclusion.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/subcommands/maestro/validate/builds.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/subcommands/maestro/validate/boots.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/subcommands/results/__init__.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/api.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/libs/regression.py

## 11. MCP as an experimental interface

12:30-13:40 (70 seconds)

The optional MCP server exposes KernelCI operations to compatible automation and AI clients. A client can explore results and known issues, inspect nodes, and, with the required configuration, request a checkout or retry. Those operations use the public Python client.

The interface is explicitly experimental. Tool names, arguments and response formats may change. Read-only queries and job-triggering tools carry different annotations, but those annotations are hints to the client, not an authorization system. The documented HTTP transport has no authentication layer, so local stdio is the straightforward option shown here.

For this MC, I would treat MCP as another consumer of the same evidence and configuration contracts. It makes reliable shared methods more valuable. The release decision and the policy for starting jobs still belong to the integrating workflow and its operator.

Sources:
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/docs/mcp.md
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/mcp/tools_dashboard.py
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/mcp/tools_maestro.py

## 12. Proposed priorities

13:40-15:05 (85 seconds)

My suggested first priority is comparison correctness, because other workflows will consume that output. Scope history to the candidate, preserve configuration across interfaces, and make incomplete data visible. We should agree on the cases that must pass before anyone relies on a release gate.

In parallel, a patch review integration can use the existing patchset operation. The integrating tool would handle b4 or Patchwork discovery and series versions, while kci-dev supplies submission and result access. We need to agree where that responsibility lives and how results link back to the exact series.

A reproducible test plan would record the base revision, patches, selected jobs and expected coverage, together with completion rules. That would help both pre-submit testing and release review. Richer lab metadata, caching and multi-tree reporting remain useful follow-up work. I would sequence them around a real maintainer workflow, with concrete acceptance criteria and someone willing to validate it.

Sources:
https://lpc.events/event/20/contributions/2534/
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/docs/patchset.md
https://github.com/kernelci/kci-dev/blob/e4c00874f1bcfbd6a6f1cdd513320b2e95713a42/kcidev/api.py
The workstream order and ownership split are proposals for discussion.

## 13. Decisions for this MC

15:05-16:00 (55 seconds)

I would like us to leave this discussion with one workflow, an agreed evidence contract and people who can validate it against real kernel development. If patch review is the priority, let's choose a series workflow and define how its results reach the reviewer. If release review is the priority, let's choose a tree and write down its required coverage and failure policy.

The project already has useful operations to build on. Your experience can help decide which connections matter most. Which workflow would make you use kci-dev regularly, and who would like to work through it with us?

Pause here and invite discussion. The suggested timing reaches 16:00; adjust the pace to leave room for discussion.

Sources:
https://kci.dev
https://github.com/kernelci/kci-dev
