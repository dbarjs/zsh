# ni-aliases

Short aliases over [antfu's `ni`](https://github.com/antfu/ni) — package-manager-agnostic
wrappers that detect npm / yarn / pnpm / bun automatically.

## Prerequisite

These aliases call `ni` and `nr`. Install them first:

```sh
npm i -g @antfu/ni
```

## Aliases

| Alias | Expands to |
|---|---|
| `nio` | `ni --prefer-offline` |
| `s` | `nr start` |
| `d` | `nr dev --no-fork` |
| `play` | `nr play --no-fork` |
| `b` | `nr build` |
| `bw` | `nr build --watch` |
| `t` | `nr test` |
| `tu` | `nr test -u` |
| `tw` | `nr test --watch` |
| `w` | `nr watch` |
| `p` | `nr play` |
| `c` | `nr typecheck` |
| `lint` | `nr lint` |
| `lintf` | `nr lint --fix` |
| `release` | `nr release` |
| `re` | `nr release` |

## Install (Sheldon)

```toml
[plugins.ni-aliases]
github = "dbarjs/zsh"
dir = "plugins/ni-aliases"
```
