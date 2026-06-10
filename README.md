# zsh

A small monorepo of independent zsh plugins, designed to be consumed by
[Sheldon](https://sheldon.cli.rs/) — the Rust zsh plugin manager.

Each plugin owns a single concern and lives in its own `plugins/<name>/` directory, so you
can enable exactly the ones you want and skip the rest.

## Plugins

| Plugin | Concern |
|---|---|
| [`git-aliases`](plugins/git-aliases/README.md) | Short aliases for everyday git commands. |
| [`claude-aliases`](plugins/claude-aliases/README.md) | Short aliases for the Claude Code CLI. |
| [`ni-aliases`](plugins/ni-aliases/README.md) | Aliases over antfu's `ni` / `nr` tools. |
| [`history-config`](plugins/history-config/README.md) | zsh command history configuration. |
| [`read-env`](plugins/read-env/README.md) | `read_env` — load variables from a dotenv file. |
| [`devcontainer-templates`](plugins/devcontainer-templates/README.md) | Apply devcontainer templates from a registry. |
| [`window-title`](plugins/window-title/README.md) | Sync the terminal title with the shell. |

## Install with Sheldon

Add entries to your `plugins.toml`. Each plugin is matched by Sheldon's default templates,
so a `dir` pointing at the plugin directory is all you need:

```toml
# granular — enable only what you want
[plugins.git-aliases]
github = "dbarjs/zsh"
dir = "plugins/git-aliases"

[plugins.read-env]
github = "dbarjs/zsh"
dir = "plugins/read-env"

# ...or load everything in one entry
[plugins.dbarjs-zsh]
github = "dbarjs/zsh"
use = ["plugins/*/*.plugin.zsh"]
```

Then run `sheldon lock` and make sure `eval "$(sheldon source)"` is in your `.zshrc`.

## Inspect what's loaded

Each plugin from this repo appends its name to `$DBARJS_ZSH_PLUGINS` on load. List the
dbarjs/zsh plugins active in your current shell with:

```sh
print -l $DBARJS_ZSH_PLUGINS
```

The array is project-scoped — only plugins from this repo populate it, so unrelated
Sheldon plugins won't appear.

## Repository layout

```
plugins/<name>/<name>.plugin.zsh   the plugin
plugins/<name>/README.md           per-plugin docs
docs/adr/                          architecture decision records
CONTEXT.md                         glossary of project terms
```

See [`CONTEXT.md`](CONTEXT.md) for terminology,
[`docs/adr/0001-monorepo-of-independent-plugins.md`](docs/adr/0001-monorepo-of-independent-plugins.md)
for why the repo is structured this way,
[`docs/adr/0002-plugin-names-are-behavior-noun-phrases.md`](docs/adr/0002-plugin-names-are-behavior-noun-phrases.md)
for why plugins are named the way they are, and
[`docs/adr/0003-plugin-registry-as-shared-shell-array.md`](docs/adr/0003-plugin-registry-as-shared-shell-array.md)
for how `$DBARJS_ZSH_PLUGINS` works.
