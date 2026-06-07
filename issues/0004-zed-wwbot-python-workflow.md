---
id: 0004
title: Add Zed project config for wwbot
kind: enhancement
status: ready-for-agent
slice_type: AFK
blocked_by:
  - 0002
created: 2026-05-07
---

## Parent

`issues/0001-prd-zed-worldflow.md`

## What to build

Add `.zed` configuration for the Python repo `wwbot` so Zed respects the repo's type-checking and formatting setup and offers useful run/debug tasks.

### Files to change

- `/home/love/Projects/worldwide/wwbot/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwbot/.zed/tasks.json` new

### Repo context to honor

- `/home/love/Projects/worldwide/wwbot/pyproject.toml`
- `/home/love/Projects/worldwide/wwbot/.pre-commit-config.yaml`
- `/home/love/Projects/worldwide/wwbot/.vscode/settings.json`
- `/home/love/Projects/worldwide/wwbot/.vscode/launch.json`
- `/home/love/Projects/worldwide/wwbot/.envrc`

### Config goals

- Mirror the repo's Pyright settings in Zed's language/LSP config.
- Keep Ruff-driven formatting and lint behavior aligned with the repo.
- Add tasks for the common bot workflows: run, test, and any build or packaging command that the repo already uses.
- If the current VS Code debug configs translate cleanly, add the equivalent debug task or launch entry.
- Respect the repo's `.venv` setup and `use flake` shell.

### Notes

The repo already suppresses a lot of Pyright noise in `pyproject.toml` and VS Code settings. Zed should not reintroduce that noise.

## Acceptance criteria

- [ ] `wwbot/.zed/settings.json` reflects the repo's Python analysis and formatting choices.
- [ ] `wwbot/.zed/tasks.json` exposes the main Python workflows.
- [ ] Zed uses the repo shell and sees the virtual environment.
- [ ] Zed does not surface the suppressed Pyright noise again.
- [ ] The config stays close to the repo's current workflow.

## Blocked by

- `issues/0002-zed-global-home-manager-module.md`
