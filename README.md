# nvim

Personal Neovim configuration based on [NvChad](https://nvchad.com/).

## Fresh Install

After cloning this repo to `~/.config/nvim`, open Neovim and run:

```vim
:Lazy sync
:MasonInstallAll
:TSUpdate
```

## Setup

### Python Debugging (DAP)

Create a dedicated virtualenv for debugpy (the Python debug adapter):

```bash
mkdir -p ~/.venvs
python3 -m venv ~/.venvs/debugpy
~/.venvs/debugpy/bin/pip install debugpy
```

This keeps debugpy separate from your projects. When debugging, your project's venv is used for running code (activate it before opening nvim), while this venv provides the debug adapter.

### Go Debugging (DAP)

Install delve:

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Keybindings

### General

| Key | Action |
|-----|--------|
| `;` | Enter command mode |
| `<leader>q` | Quit buffer |
| `<leader>fm` | Format file |
| `c` | Change (without yanking) |

### Clipboard

| Key | Action |
|-----|--------|
| `<leader>y` | Yank to system clipboard |
| `<leader>yy` | Yank line to system clipboard |
| `<leader>y` (visual) | Yank selection to system clipboard |

### Window Resizing

| Key | Action |
|-----|--------|
| `=` | Increase width |
| `-` | Decrease width |
| `+` | Increase height |
| `_` | Decrease height |

### Buffers

| Key | Action |
|-----|--------|
| `<leader>bdo` | Delete all other buffers |

### Indentation

| Key | Action |
|-----|--------|
| `>` (visual) | Indent and keep selection |
| `<` (visual) | Unindent and keep selection |

### Terminal

| Key | Action |
|-----|--------|
| `<C-Space>` | Escape terminal mode |

### Search & Replace (Spectre)

| Key | Action |
|-----|--------|
| `<leader>S` | Toggle Spectre |
| `<leader>sw` | Search current word |
| `<leader>sw` (visual) | Search selection |
| `<leader>sp` | Search in current file |

### Git (Gitsigns)

| Key | Action |
|-----|--------|
| `]c` | Next git hunk |
| `[c` | Previous git hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |
| `<leader>hD` | Diff this ~ |
| `<leader>fg` | Find git modified files |

### Todo Comments

| Key | Action |
|-----|--------|
| `]t` | Next todo comment |
| `[t` | Previous todo comment |
| `<leader>ft` | Find todos (Telescope) |

### AI Completion (Minuet)

| Key | Action |
|-----|--------|
| `<leader>mt` | Toggle Minuet AI |
| `<A-A>` (insert) | Accept full completion |
| `<A-a>` (insert) | Accept line |
| `<A-z>` (insert) | Accept n lines |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Start/continue debugging |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dr` | Open REPL |
| `<leader>dl` | Run last |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Terminate |
| `<leader>dpt` | Debug Python test method |
| `<leader>dpc` | Debug Python test class |
| `<leader>dgt` | Debug Go test |
| `<leader>dgl` | Debug last Go test |
