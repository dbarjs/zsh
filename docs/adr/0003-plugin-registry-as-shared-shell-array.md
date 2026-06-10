# 3. Plugin registry as a shared shell array

Status: Accepted

## Context

[ADR-0001](./0001-monorepo-of-independent-plugins.md) established that plugins are
independent — none sources another. Users still want a way to answer "which dbarjs/zsh
plugins are loaded in this shell session?", scoped to this repo (not every Sheldon plugin
they have installed). Three distinct things could be called "installed":

- **Available** — what exists in `plugins/`. Answered by `ls plugins/`.
- **Enabled** — what the user declared in `plugins.toml`. Answered by `sheldon list`.
- **Loaded** — what was actually sourced into the running shell. **Not** answerable from
  static state — needs runtime support.

Only the third is unanswerable today, and it is the one users mean when asking the
question in a live shell.

Four options were considered:

1. **A lister plugin** other plugins depend on. Cleanest API surface, but stretches
   ADR-0001's independence rule — every plugin would reference a name owned by another
   plugin.
2. **A detection plugin** that scans Sheldon's state or sourced paths at query time. No
   changes to existing plugins, but brittle and order-dependent.
3. **A wrapper layer** — split each plugin into `<name>.zsh` (logic) +
   `<name>.plugin.zsh` (boilerplate wrapper that registers and sources the inner file).
   Pays off if other cross-cutting concerns accumulate (opt-out flags, prerequisite
   checks, timing). For one concern, it adds an indirection that costs readability.
4. **Pure convention** — every plugin appends its own name to a well-known shell array
   on load. No new plugin, no wrapper, no shared lib. One line per plugin.

## Decision

Adopt option 4. The **plugin registry** is the shell-local array `DBARJS_ZSH_PLUGINS`.
Each plugin contains this line:

```zsh
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})
```

- `typeset -gaU` declares the array global and **unique** — re-sourcing a plugin does not
  duplicate entries. The first `typeset -ga`-equivalent call wins; later calls are no-ops.
- `${${0:A:h}:t}` resolves the plugin's own directory name from its file path — no
  hardcoded name. The directory name is already the canonical identifier under
  [ADR-0002](./0002-plugin-names-are-behavior-noun-phrases.md), so the registry inherits
  that single source of truth.
- No query function is shipped. Inspection is `print -l $DBARJS_ZSH_PLUGINS`. The
  registry is data, not API.

## Consequences

- **Public contract.** `$DBARJS_ZSH_PLUGINS` is now part of this repo's public surface.
  Renaming or removing it would break any consumer scripting against it.
- **One-line discipline.** Every plugin must contain the registration line. The
  `write-a-plugin` skill is updated to emit it by default; CI lint can grep for it to
  enforce uniformity.
- **ADR-0001 stands.** No plugin sources another and no plugin depends on another being
  loaded first — they only share a conventional variable name. Independence is preserved.
- **No wrapper layer.** If a second cross-cutting concern ever appears (opt-out flags,
  prereq checks, timing), revisit the wrapper option from the rejected list. One concern
  does not justify the indirection.
- **Project-scoped by construction.** Only plugins inside this repo run the line, so the
  registry never reports unrelated Sheldon plugins — no namespace filter needed.
- **The registry answers one question.** "Which dbarjs/zsh plugins are loaded right now?"
  Available is `ls plugins/`; enabled is `sheldon list`; loaded is the registry. The
  three are kept distinct on purpose.
