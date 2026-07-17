# claude-session-names — Claude Code sessions auto-named after the working directory
# Provides a `claude` wrapper function; the real CLI always runs via `command claude`.
# See: plugins/claude-session-names/README.md

# Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

# Skip injection when these appear: they resume/rename sessions, run headless,
# or reject --session-name with a usage error. Extend as the CLI grows.
typeset -ga _claude_session_names_skip_flags=(
  -n --session-name -c --continue -r --resume -p --print
)
typeset -ga _claude_session_names_skip_subcommands=(
  agents doctor install mcp migrate-installer plugin resume setup-token update
)

claude() {
  local arg first_positional=''
  for arg in "$@"; do
    if [[ $arg == --session-name=* ]] ||
       (( ${_claude_session_names_skip_flags[(Ie)$arg]} )); then
      command claude "$@"
      return
    fi
    [[ $arg != -* && -z $first_positional ]] && first_positional=$arg
  done
  if (( ${_claude_session_names_skip_subcommands[(Ie)$first_positional]} )); then
    command claude "$@"
    return
  fi
  command claude --session-name "${(%):-%2~}" "$@"
}
