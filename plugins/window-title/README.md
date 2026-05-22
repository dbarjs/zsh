# window-title

Keeps the terminal window title in sync with the shell:

- **Idle** (at the prompt) — shows the current directory.
- **Running** a command — shows the command line.

## How it works

It registers two hooks via `add-zsh-hook`:

- `precmd` → emits `\e]0;%~\a` (the directory) before each prompt.
- `preexec` → emits `\e]0;<command>\a` before each command runs.

Using `add-zsh-hook` (rather than appending to `precmd_functions`) makes the plugin safe to
re-source — the hooks are not registered twice.

## Install (Sheldon)

```toml
[plugins.window-title]
github = "dbarjs/zsh"
dir = "plugins/window-title"
```
