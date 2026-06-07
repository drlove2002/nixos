---
id: 0005
title: Add Zed project config for wwpage
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

Add `.zed` configuration for the Next.js repo `wwpage` so Zed works smoothly with the repo's TypeScript, React, and app-router workflow.

### Files to change

- `/home/love/Projects/worldwide/wwpage/.zed/settings.json` new
- `/home/love/Projects/worldwide/wwpage/.zed/tasks.json` new

### Repo context to honor

- `/home/love/Projects/worldwide/wwpage/tsconfig.json`
- `/home/love/Projects/worldwide/wwpage/package.json`
- `/home/love/Projects/worldwide/wwpage/next.config.mjs`
- `/home/love/Projects/worldwide/wwpage/.vscode/launch.json`
- `/home/love/Projects/worldwide/wwpage/.envrc`

### Config goals

- Make Zed pick up the TypeScript path aliases and Next.js project layout.
- Add tasks for the common frontend workflow: dev server, build, test, and any lint/typecheck command the repo already relies on.
- Keep the config compatible with the repo's `pnpm` workflow.
- Include the repo's existing Node tooling assumptions in the editor setup.
- Translate the current VS Code launch workflow if it fits Zed cleanly.

## Acceptance criteria

- [ ] `wwpage/.zed/settings.json` matches the repo's TypeScript and Next.js setup.
- [ ] `wwpage/.zed/tasks.json` exposes the main frontend workflows.
- [ ] Zed loads the repo shell and can run the pnpm-based commands.
- [ ] Zed respects the path aliases from `tsconfig.json`.
- [ ] The config stays focused on the workflow used in this repo.

## Blocked by

- `issues/0002-zed-global-home-manager-module.md`
