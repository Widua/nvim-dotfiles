# Neovim Configuration

Leader and local leader are both `<Space>`.

## External Software

- `git`, `make`, `unzip`, and a C compiler
- Rust/Cargo for compiling `blink.cmp`
- `ripgrep`, `fd`, `jq`, and `xmllint`
- A clipboard provider (`xclip`, `xsel`, or platform equivalent)
- A Nerd Font (optional, for icons)
- Language toolchains as needed: Java/JDK, Gradle, Kotlin, Node.js, Go, and Python

LSP servers and `stylua` are installed through Mason. Java support expects a JDK
and an IntelliJ server under `~/.local/share/intellij-server`.

## Custom Mappings

| Mapping | Action |
| --- | --- |
| `<C-h/j/k/l>` | Move between windows |
| `<leader>pv` | Open the file explorer |
| `<leader>q` | Open the diagnostic list |
| `<leader>ff` | Format the buffer |
| `<leader>fj` / `<leader>fx` | Format JSON / XML |
| `<leader>sf` / `<leader>sg` | Find files / live grep |
| `<leader>sh` / `<leader>sk` | Search help / keymaps |
| `<leader>a` | Add the file to Harpoon |
| `<A-1>` ... `<A-4>` | Open Harpoon mark 1 ... 4 |
| `<A-w>` / `<A-Tab>` | Next / previous Harpoon mark |
| `<A-e>` | Show Harpoon marks |
| `<leader>oa` / `<leader>os` | Ask / select with OpenCode |
| `go` / `goo` | Send a visual selection / line to OpenCode |

When an LSP is attached: `gd`, `gD`, `gr`, `gi`, `ga`, `gO`, `gW`, and `gt` navigate
definitions, declarations, references, implementations, actions, symbols, and tests;
`<leader>rr` renames and `<leader>th` toggles inlay hints.

## Custom Plugins

- [widua/nvim-intellij-lsp](https://github.com/widua/nvim-intellij-lsp)
- [widua/gradle-nvim](https://github.com/widua/gradle-nvim)
