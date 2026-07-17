# claude-session-names

Claude Code session naming: sessions are automatically named after the current working
directory — so terminal tabs read `✳ dev/zsh` instead of an indistinguishable
`✳ Claude Code` — and `ccn <name...>` starts a session named by hand.

## Usage

Run `claude` as usual. The plugin defines a `claude` wrapper function that injects
`--name <name>` before launching the real CLI, where `<name>` is zsh's `%2~`
expansion — the last two path components, home-abbreviated:

| Directory | Injected name |
|---|---|
| `~/dev/zsh` | `dev/zsh` |
| `~/dev` | `~/dev` |
| `~` | `~` |

To name a session yourself, use `ccn` — everything after the word becomes the name, no
quoting needed:

```sh
ccn fix of issue 123    # same as: claude --name 'fix of issue 123'
```

Because all arguments are joined into the name, `ccn` never takes Claude flags or a
prompt (`ccn fix --resume bug` names the session literally `fix --resume bug`). Bare
`ccn` is a usage error.

Injection is **skipped** whenever it would misfire, and the arguments pass through
untouched:

- You passed a name yourself: `-n`, `--name`, `--name=…` (or the older
  `--session-name` spellings) — this is also how `ccn` passes through.
- The session already exists: `-c`/`--continue`, `-r`/`--resume`.
- Headless mode: `-p`/`--print`.
- A known subcommand: `agents`, `doctor`, `install`, `mcp`, `migrate-installer`,
  `plugin`, `resume`, `setup-token`, `update`.

The subcommand list lives in `$_claude_session_names_skip_subcommands` at the top of the
plugin. If a future CLI version adds a subcommand that rejects `--name`, the
failure is a visible usage error — add the word to the array.

The aliases from `claude-aliases` (`cc`, `ccc`, `ccr`, `ccd`) expand to the word `claude`
and therefore route through the wrapper automatically; `ccc`/`ccr` hit the
`--continue`/`--resume` skip rule by design, and `ccn` completes that `cc*` family from
this plugin's side. Neither plugin depends on the other — both only require the external
`claude` CLI.

## How it works

Claude Code owns the terminal title: it writes `✳ Claude Code` on start and keeps
rewriting the title as the session progresses, so anything a shell hook prints is
overwritten immediately (which is why the `window-title` plugin can't help here). The
title text Claude writes is the **session name** when one exists (set via `/rename` or
`--name`), prefixed by a status glyph that keeps signalling state — e.g. blocked
awaiting input. Naming the session is therefore the one mechanism that puts the directory
in the tab while keeping Claude's live status indicator.

Alternatives considered and rejected:

- **Shell-written escape sequences** — overwritten by Claude's own title writes within
  moments of launch.
- **`CLAUDE_CODE_DISABLE_TERMINAL_TITLE`** — an undocumented env var that stops Claude
  writing titles entirely; the shell could then own the title, but the status glyph and
  any session awareness are lost.

Trade-off: a named session no longer shows Claude's auto-generated task-summary titles
(`✳ Fix menu overlay…`) — you get the stable directory name instead. Bonus: the names
also show up in `claude resume` listings.

Caveats:

- Setting `terminalTitleFromRename: false` in Claude Code's settings stops session names
  from driving the title, which defeats this plugin.
- The title behavior above is undocumented, confirmed by inspecting CLI v2.1.202 and
  re-checked against v2.1.212 (which documents `-n, --name`; `--session-name` remains an
  undocumented alias); a future Claude Code version may change it.

## Install (Sheldon)

```toml
[plugins.claude-session-names]
github = "dbarjs/zsh"
dir = "plugins/claude-session-names"
```
