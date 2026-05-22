# history-config

zsh command history configuration.

## What it sets

| Setting | Value | Purpose |
|---|---|---|
| `HISTFILE` | `$HOME/.zsh_history` | Where history is stored. |
| `HISTSIZE` | `10000` | Lines kept in memory per session. |
| `SAVEHIST` | `10000` | Lines persisted to `HISTFILE`. |
| `APPEND_HISTORY` | _enabled_ | Sessions append to the file instead of overwriting it. |

## Install (Sheldon)

```toml
[plugins.history-config]
github = "dbarjs/zsh"
dir = "plugins/history-config"
```
