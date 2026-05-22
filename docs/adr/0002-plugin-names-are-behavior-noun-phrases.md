# 2. Plugin names are behavior noun phrases

Status: Accepted

## Context

[ADR-0001](./0001-monorepo-of-independent-plugins.md) established the monorepo layout
(`plugins/<name>/<name>.plugin.zsh`) but chose subject-style names for the initial six
plugins: `git`, `node`, `history`, `env`, `devcontainer`, `window-title`.

Two of those names proved actively misleading in use:

- **`node`** wraps antfu's `ni` / `nr` — *not* the `node` binary. The aliases are
  package-manager-agnostic (npm / yarn / pnpm / bun), and the install prerequisite is
  `@antfu/ni`. A reader seeing `[plugins.node]` in `plugins.toml` will reasonably assume
  the plugin configures Node itself.
- **`env`** collides with `env(1)` and `$ENV`, and "the env / dotenv plugin" in most
  ecosystems (Node, Python, Rust) implies *automatic* loading of `.env` at shell startup.
  This plugin deliberately does **not** auto-load — it exposes `read_env`, which the user
  must call explicitly.

Without a rule, future plugins will drift back into the same trap. We want a naming
convention that prevents this.

Three patterns were considered:

1. **Subject names** (status quo from ADR-0001) — name the topic (`git`, `history`). Short
   and matches oh-my-zsh / zsh-users convention, but tolerates misleading names like
   `node` and `env`.
2. **`<verb>-<object>` command form** — `alias-git`, `load-dotenv`,
   `apply-devcontainer-template`. Very direct but verb-first is unusual in zsh-plugin
   ecosystems, and lengths drift wildly across the set.
3. **Noun-phrase behavior names** — `git-aliases`, `history-config`, `read-env`. Each name
   is a noun describing what the plugin gives you. Reads naturally, scales with
   per-plugin judgement, matches the pre-existing `window-title`.

## Decision

Adopt pattern 3: **plugin names are noun phrases describing what the plugin provides.**

- Where the plugin is "a bag of \<thing\>", use `<subject>-<kind>`:
  `git-aliases`, `ni-aliases`, `history-config`.
- Where a single noun fits the entire plugin, use it bare:
  `read-env`, `window-title`, `devcontainer-templates`.
- The plugin directory name, the inner `<name>.plugin.zsh` filename, and the `[plugins.<name>]`
  table key all match — this is the load-bearing layout ADR-0001 records.

Renames performed:

| Old | New |
|---|---|
| `plugins/git` | `plugins/git-aliases` |
| `plugins/node` | `plugins/ni-aliases` |
| `plugins/history` | `plugins/history-config` |
| `plugins/env` | `plugins/read-env` |
| `plugins/devcontainer` | `plugins/devcontainer-templates` |
| `plugins/window-title` | _unchanged_ |

Function and alias names inside each plugin (`read_env`, `apply_devcontainer_template`,
`applytemplate`) are unchanged — they already describe what they do and live in a
separate namespace from plugin directory names.

## Consequences

- **This invokes the breaking change ADR-0001 warned about.** Every Sheldon consumer's
  `plugins.toml` must update the `[plugins.<name>]` keys and `dir = "plugins/<name>"`
  values. Acceptable now because the repo has effectively one consumer; the cost of the
  same rename a year from now would only be higher.
- New plugins follow this rule. A future PR adding a plugin called `python` (subject)
  would be reviewed against this ADR and renamed to something like `pyenv-shims`
  (behavior) before merging.
- `CONTEXT.md` is not updated. Naming is a rule, not a glossary term; the glossary
  remains a glossary.
- ADR-0001's structural decision (monorepo of independent plugins) still stands. Only its
  example names are now historical; this ADR supersedes them.
