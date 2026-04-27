# VSCode config

Approximate port of the nvim config for VSCode + Remote-SSH.

## Install

```sh
# Extensions
cat ./extensions.txt | xargs -L1 code --install-extension

# Merge settings into user config
# macOS: ~/Library/Application Support/Code/User/settings.json
# Linux: ~/.config/Code/User/settings.json
# Windows: %APPDATA%\Code\User\settings.json

# Keybindings
# Same path but keybindings.json
```

If you already have settings, merge the JSON manually - don't overwrite.

## Notes

### LSP
Only Python + C++ are configured. Other langs use whatever extension provides LSP.

- Python: `ms-python.python` + `ms-python.debugpy` + `ms-python.black-formatter`
- C/C++: `llvm-vs-code-extensions.vscode-clangd` (no clang-format file included - add one per project)

### Keybindings mapped from nvim

| nvim                  | VSCode action                 | notes                            |
| --------------------- | ----------------------------- | -------------------------------- |
| `K`                   | show hover                    |                                  |
| `<C-w>d`              | show hover                    | nvim 0.12 show-diagnostic approx |
| `grn`                 | rename                        |                                  |
| `gra`                 | code action                   | normal + visual                  |
| `grr`                 | go to references              |                                  |
| `gri`                 | go to implementation          |                                  |
| `grt`                 | go to type definition         |                                  |
| `grx`                 | run codelens                  |                                  |
| `gO`                  | go to symbol                  |                                  |
| `grd`                 | problems panel                | telescope diagnostics approx     |
| `]d` / `[d`           | next/prev diagnostic          | nvim 0.12 defaults               |
| `]q` / `[q`           | next/prev problem (all files) |                                  |
| `<C-]>`               | go to definition              |                                  |
| `<leader>ch`          | toggle inlay hints            |                                  |
| `<leader>j/k`         | next/prev git hunk            |                                  |
| `<leader>gb`          | toggle line blame             | gitlens                          |
| `<leader>gu`          | unstage hunk                  |                                  |
| `<leader>j/<leader>k` | next/prev change              |                                  |
| `<leader>md`          | debug: selection to REPL      | vimspector approx                |
| `<leader>mv`          | debug: show hover             |                                  |
| `<leader>f`           | command palette               |                                  |
| `<leader>fff`         | find file (quickOpen)         | telescope find_files             |
| `<leader>ffr`         | find in files                 | telescope live_grep              |
| `<leader>ffb`         | recent editors                | telescope buffers                |
| `<leader>ff/`         | find in file                  | telescope current_buffer_fuzzy   |
| `<leader>fgv`         | SCM view                      | telescope git_status             |
| `<leader>fqf`         | problems panel                | telescope quickfix               |
| `<leader>nn`          | explorer                      | oil float                        |
| `<leader>b`           | navigate back                 | `<C-^>`                          |
| `<leader>o`           | toggle light/dark             | theme toggle                     |
| `<leader>mt`          | split terminal                |                                  |
| `gqg`                 | format document               | `gggqG`                          |
| `vv`                  | visual line                   |                                  |
| `V`                   | visual to EOL                 |                                  |
| `G`                   | jump to end + center          | `Gzz`                            |
| `<A-j>/<A-k>`         | move line(s) up/down          | normal + visual                  |
| `<A-h>/<A-l>`         | prev/next editor tab          |                                  |
| `<C-h/j/k/l>`         | focus editor group            | normal + insert                  |
| `<C-A-h/j/k/l>`       | resize editor                 | winsize approx (not edge-aware)  |
| `<F5>`                | start/continue debug          |                                  |
| `<F9>`                | toggle breakpoint             |                                  |

### Gaps (not portable)

- **`<leader>tt`** (insert TODO comment) - use VSCode snippet or TODO Highlight ext instead
- **`<leader>mc`** (toggle cursorline) - mapped to sticky scroll toggle instead; no direct equivalent
- **`<leader>gv`** (preview hunk inline) - no good VSCode equivalent; use gitlens hover
- **`<leader>gj/<leader>gk`** (first/last hunk) - mapped to next/prev change, not first/last
- **Hybrid line numbers** (relative off in insert) - VSCode always shows relative; can't toggle per-mode
- **Direction-aware window resize** - VSCode resize isn't edge-aware; `<C-A-hjkl>` grows/shrinks uniformly
- **`<C-i>` / `<C-S-i>`** (snippet jump fwd/back) - use `Tab` / `Shift+Tab` in VSCode snippet mode
- **`<leader>fqq`** (quickfix history) - no equivalent in VSCode
- **Scroll right/left** (`<A-y>/<A-e>`) - use scrollbar or `Alt+scroll`
- **Trailing WS** - `files.trimTrailingWhitespace: true` applies globally (not per-filetype); markdown has it disabled
