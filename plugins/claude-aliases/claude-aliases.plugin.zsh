# claude-aliases — short aliases for the Claude Code CLI
# Requires the `claude` CLI: https://claude.com/claude-code
# Note: `cc` shadows the cc(1) C compiler at interactive prompts only.
# See: plugins/claude-aliases/README.md

# Register in $DBARJS_ZSH_PLUGINS — see docs/adr/0003-plugin-registry-as-shared-shell-array.md
typeset -gaU DBARJS_ZSH_PLUGINS; DBARJS_ZSH_PLUGINS+=(${${0:A:h}:t})

alias cc='claude'
alias ccc='claude --continue'
alias ccd='claude --dangerously-skip-permissions'
alias ccr='claude --resume'
alias cclatestbrew='brew upgrade --cask claude-code@latest'
