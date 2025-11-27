---
marp: true
theme: gyaru
title: Getting Started With New KernelCI CLI Tools
paginate: true
footer: "Your Name – OSS Japan 2025"
---

# Getting Started With New KernelCI CLI Tools

### for Automating Linux Kernel Testing and Validation

Your Name  
KernelCI / Gentoo / etc.

---

## Motivation: Why Kernel QA Is Hard

- Many trees, branches and configurations
- Multiple architectures, boards and toolchains
- CI dashboards are powerful but not ergonomic
- Developers still click UIs or write ad-hoc scripts

---

## KernelCI in One Slide

- Upstream, open testing for the Linux kernel
- Builds, boots and tests across labs
- Great data, but interaction is:
  - Mostly via web UI
  - Raw REST APIs
- Need something ergonomic in the terminal

---

## Real-World Context: gentoo-sources

- Fast-moving tree with many patches
- High pressure to avoid regressions
- Need quick, scriptable visibility into CI results
- KernelCI CLI tools are built with this reality in mind

---

## Introducing the KernelCI CLI Tools

- **kci-dev**
  - Developer-focused CLI for interacting with KernelCI
- **kci-deploy** *(work in progress)*
  - Tool for deploying local / internal KernelCI maestro stacks
- Goal: make KernelCI a first-class tool in your terminal

---

<!-- _class: highlight -->

## kci-dev: What You Can Do Today

Examples (adapt to real syntax):

```bash
kci-dev builds list --branch topic/foo
kci-dev results summary --commit <sha>
kci-dev builds retry --build-id <id>
