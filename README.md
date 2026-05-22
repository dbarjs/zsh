# zsh

A small monorepo of independent zsh plugins, designed to be consumed by
[Sheldon](https://sheldon.cli.rs/) — the Rust zsh plugin manager.

Each plugin owns a single concern and lives in its own `plugins/<name>/` directory, so you
can enable exactly the ones you want and skip the rest.

## Plugins

| Plugin | Concern |
|---|---|
| [`git`](plugins/git/README.md) | Short aliases for everyday git commands. |
| [`node`](plugins/node/README.md) | Aliases over antfu's `ni` / `nr` tools. |
| [`history`](plugins/history/README.md) | zsh command history configuration. |
| [`env`](plugins/env/README.md) | `read_env` — load variables from a dotenv file. |
| [`devcontainer`](plugins/devcontainer/README.md) | Apply devcontainer templates from a registry. |
| [`window-title`](plugins/window-title/README.md) | Sync the terminal title with the shell. |

## Install with Sheldon

Add entries to your `plugins.toml`. Each plugin is matched by Sheldon's default templates,
so a `dir` pointing at the plugin directory is all you need:

```toml
# granular — enable only what you want
[plugins.git]
github = "dbarjs/zsh"
dir = "plugins/git"

[plugins.env]
github = "dbarjs/zsh"
dir = "plugins/env"

# ...or load everything in one entry
[plugins.dbarjs-zsh]
github = "dbarjs/zsh"
use = ["plugins/*/*.plugin.zsh"]
```

Then run `sheldon lock` and make sure `eval "$(sheldon source)"` is in your `.zshrc`.

## Repository layout

```
plugins/<name>/<name>.plugin.zsh   the plugin
plugins/<name>/README.md           per-plugin docs
docs/adr/                          architecture decision records
CONTEXT.md                         glossary of project terms
```

See [`CONTEXT.md`](CONTEXT.md) for terminology and
[`docs/adr/0001-monorepo-of-independent-plugins.md`](docs/adr/0001-monorepo-of-independent-plugins.md)
for why the repo is structured this way.
