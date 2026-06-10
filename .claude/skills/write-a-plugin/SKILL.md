---
name: write-a-plugin
description: Scaffold a new zsh plugin in the dbarjs/zsh monorepo following the Sheldon layout and project ADRs (single concern, behavior noun-phrase name). Use when the user wants to add a new plugin, split a concern out of an existing plugin, or asks "write a plugin for X" in this repo.
---

# Write a plugin

Scaffolds one plugin in `plugins/<name>/` for the dbarjs/zsh repo. Read
`CONTEXT.md` and `docs/adr/0001-*`, `docs/adr/0002-*`, `docs/adr/0003-*`
before scaffolding.

## Checklist

1. **State the one concern.** Write it as a single sentence. If two concerns
   appear, stop and propose two plugins. (ADR-0001, CONTEXT.md "Concern")
2. **Pick a behavior noun-phrase name.** `<subject>-<kind>` for "a bag of
   things" (`git-aliases`), bare noun where one fits (`read-env`,
   `window-title`). Reject subject names like `node`/`env`. (ADR-0002)
3. **Scaffold** `plugins/<name>/<name>.plugin.zsh` and `plugins/<name>/README.md`.
4. **Wire** the new plugin into the `## Plugins` table in root `README.md`.
5. **Include the registry line.** Every entry file appends to
   `$DBARJS_ZSH_PLUGINS` — see "Plugin registry line" below. (ADR-0003)
6. **Lint** with `zsh -n plugins/<name>/<name>.plugin.zsh` (same check as
   `.github/workflows/lint.yml`).

## Entry-file header

Two lines, matching `plugins/git-aliases/git-aliases.plugin.zsh` and
`plugins/window-title/window-title.plugin.zsh`:

    # <name> — <one-line concern>
    # See: plugins/<name>/README.md

If the plugin defines a public function (like `read_env`), add a third line
describing what it provides and whether it auto-runs — see
`plugins/read-env/read-env.plugin.zsh`.

## Plugin registry line (mandatory)

Immediately after the header comment block, before any executable line, every
plugin must include the registration line. It is byte-identical across all
plugins — copy it verbatim. (ADR-0003, CONTEXT.md "Plugin registry")

    # Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
    typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

Do not hardcode the plugin name — the `${${0:A:h}:t}` expansion derives it
from the directory the file lives in, keeping the directory name as the
single source of truth.

## README skeleton

`# <name>` heading, one-line concern, then a `## Usage` or `## Aliases` section,
then a `## Install (Sheldon)` block with the canonical toml entry:

    [plugins.<name>]
    github = "dbarjs/zsh"
    dir = "plugins/<name>"

Mirror the prose density of `plugins/read-env/README.md` (functions) or
`plugins/git-aliases/README.md` (alias tables).

## After scaffolding

- Add a row to the `## Plugins` table in root `README.md`.
- Run `zsh -n plugins/<name>/<name>.plugin.zsh`; fix anything it reports.
- Only touch `CONTEXT.md` if you introduced a new domain term — naming is a
  rule, not a glossary term (per ADR-0002 "Consequences").
- Do **not** source another plugin from this one. (ADR-0001)
