# ni-aliases — aliases over antfu's `ni` / `nr` package-manager-agnostic tools
# Requires @antfu/ni: npm i -g @antfu/ni
# See: plugins/ni-aliases/README.md

alias nio="ni --prefer-offline"
alias s="nr start"
alias d="nr dev --no-fork"
alias play="nr play --no-fork"
alias b="nr build"
alias bw="nr build --watch"
alias t="nr test"
alias tu="nr test -u"
alias tw="nr test --watch"
alias w="nr watch"
alias p="nr play"
alias c="nr typecheck"
alias lint="nr lint"
alias lintf="nr lint --fix"
alias release="nr release"
alias re="nr release"
