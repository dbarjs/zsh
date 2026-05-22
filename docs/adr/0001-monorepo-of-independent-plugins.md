# 1. Monorepo of independent plugins

Status: Accepted

## Context

The repository started as a single `old.zsh` file bundling several unrelated concerns —
git aliases, Node tooling aliases, history settings, a dotenv loader, a devcontainer
helper, and terminal-title hooks. The file even carried a `# TODO: move to separate file`
marker. We want the repo to be consumable by [Sheldon](https://sheldon.cli.rs/) and to let
users adopt only the parts they want.

Three structures were considered:

1. **One sourced file** (the status quo) — everything loads or nothing does; no way to
   opt out of a concern; documentation has nowhere natural to live.
2. **One repo per plugin** — maximally granular, but six repos to clone, version, and
   maintain for what is one person's shell setup; high overhead.
3. **A monorepo of independent plugins** — one repo, but each concern is a separate
   plugin directory that Sheldon can enable or disable individually.

## Decision

Adopt option 3. Each concern becomes a plugin at `plugins/<name>/<name>.plugin.zsh` with
its own `README.md`. Plugins are independent — none sources another. Sheldon consumers
either list plugins granularly (`dir = "plugins/<name>"`) or load them all with a single
glob entry (`use = ["plugins/*/*.plugin.zsh"]`).

## Consequences

- Users can enable concerns à la carte from a single `github = "dbarjs/zsh"` source.
- Each plugin has a clear home for documentation and can be syntax-checked in isolation
  (see `.github/workflows/lint.yml`).
- The `plugins/<name>/<name>.plugin.zsh` naming is load-bearing: it matches Sheldon's
  default templates. Renaming the file would break the `dir = ...` form for consumers.
- Adding a new concern means adding a new plugin directory, not editing a shared file.
- `old.zsh` is removed; it is fully superseded by the `plugins/` tree.
