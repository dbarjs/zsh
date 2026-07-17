# claude-aliases

Short aliases for the [Claude Code](https://claude.com/claude-code) CLI.

Requires the `claude` binary on your `PATH`.

## Aliases

| Alias | Expands to |
|---|---|
| `cc` | `claude` |
| `ccc` | `claude --continue` |
| `ccd` | `claude --dangerously-skip-permissions` |
| `ccr` | `claude --resume` |

The `cc*` family continues in
[`claude-session-names`](../claude-session-names/README.md), which adds
`ccn <name...>` — start a session named by everything after the word.

> [!WARNING]
> `ccd` runs Claude with `--dangerously-skip-permissions`, bypassing all
> permission prompts. It sits one keystroke from the safe `cc` — type it
> deliberately, never by reflex.

> [!NOTE]
> `cc` shadows the `cc(1)` C compiler. zsh only expands aliases in interactive
> shells, so scripts, Makefiles (`$(CC)`), and direct `/usr/bin/cc` calls are
> unaffected — this only applies when you type `cc` at a prompt. Run `command cc`
> or `/usr/bin/cc` to reach the compiler.

## Install (Sheldon)

```toml
[plugins.claude-aliases]
github = "dbarjs/zsh"
dir = "plugins/claude-aliases"
```
