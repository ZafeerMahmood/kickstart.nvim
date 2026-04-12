# Neovim Config UX Improvements — Design Spec

## Goal

Improve UI/UX and performance of existing kickstart-based Neovim config. No debugger. No unnecessary bloat. Approach B: targeted additions + performance pass.

## Changes

### 1. Symbol Outline Sidebar (New Plugin)

**Plugin:** `hedyhli/outline.nvim`

- Sidebar on right side showing LSP document symbols (functions, classes, variables, types)
- Auto-follows cursor position
- Lazy-loaded on `:Outline` command
- Keymap: `<leader>o` — toggle outline

**File:** `lua/unknown/plugins/outline.lua`

### 2. Vim Training: Hardtime (New Plugin)

**Plugin:** `m4xshen/hardtime.nvim`

- Blocks repeated hjkl spam, suggests better motions
- Shows hint messages with the better alternative
- Togglable — can be disabled per-session
- Lazy-load on `VeryLazy`
- Keymap: `<leader>tH` — toggle hardtime on/off

**File:** `lua/unknown/plugins/hardtime.lua`

### 3. Vim Training: Precognition (New Plugin)

**Plugin:** `tris203/precognition.nvim`

- Shows virtual text hints of available motions above current line
- Togglable
- Lazy-load on `VeryLazy`
- Keymap: `<leader>tp` — toggle precognition

**File:** `lua/unknown/plugins/precognition.lua`

### 4. Session Restore (Existing Plugin — snacks.nvim)

Enable the built-in `session` module in snacks.nvim. No new plugin.

- Auto-save session on exit
- Restore on open (when no file args)
- Add dashboard shortcut `s` for session restore
- Keymaps:
  - `<leader>qs` — restore last session
  - `<leader>qS` — select session

**File:** `lua/unknown/plugins/snacks.lua` (modify existing)

### 5. Keymap Migration: `<leader>q` Group

`<leader>q` changes from direct action to a which-key group.

- `<leader>qq` — diagnostic quickfix list (moved from `<leader>q`)
- `<leader>qs` — restore session
- `<leader>qS` — select session

**Files:**
- `lua/unknown/core/keymaps.lua` (change `<leader>q` to `<leader>qq`)
- `lua/unknown/plugins/which-key.lua` (register `<leader>q` as group)

### 6. Startup Performance Fixes

**6a. Mason: disable auto-install on start**
- Set `run_on_start = false` in mason-tool-installer config
- Tools only installed when running `:Mason` manually

**File:** `lua/unknown/plugins/lsp.lua`

**6b. Defer spell check**
- Remove global `vim.opt.spell = true`
- Set spell via autocmd on `BufReadPost` / `BufNewFile` (skips dashboard)

**File:** `lua/unknown/core/options.lua`, `lua/unknown/core/autocmds.lua`

**6c. Remove dead requires from init.lua**
- `kickstart.plugins.indent_line` returns `{}` — remove from init.lua
- `kickstart.plugins.autopairs` — still active, keep it
- `lua/unknown/plugins/toggleterm.lua` returns `{}` — delete the file

**File:** `init.lua`

**6d. Disable unused built-in Neovim plugins**
- Add `performance.rtp.disabled_plugins` to lazy.nvim setup
- Disable: netrw, tutor, tohtml, gzip, zip, tar, matchit, matchparen (treesitter handles it)

**File:** `init.lua`

## Keymap Summary (No Conflicts)

| Keymap | Action | Group | Conflict |
|---|---|---|---|
| `<leader>o` | Toggle outline | — | None |
| `<leader>tH` | Toggle hardtime | [T]oggle | None (`<leader>th` = inlay hints) |
| `<leader>tp` | Toggle precognition | [T]oggle | None |
| `<leader>qq` | Diagnostic quickfix | [Q]uit/Session | Replaces `<leader>q` |
| `<leader>qs` | Restore session | [Q]uit/Session | None |
| `<leader>qS` | Select session | [Q]uit/Session | None |

## Files Touched

| File | Action |
|---|---|
| `lua/unknown/plugins/outline.lua` | New |
| `lua/unknown/plugins/hardtime.lua` | New |
| `lua/unknown/plugins/precognition.lua` | New |
| `lua/unknown/plugins/snacks.lua` | Modify (add session + dashboard key) |
| `lua/unknown/plugins/which-key.lua` | Modify (register new groups/keys) |
| `lua/unknown/core/keymaps.lua` | Modify (`<leader>q` -> `<leader>qq`) |
| `lua/unknown/core/options.lua` | Modify (defer spell) |
| `lua/unknown/core/autocmds.lua` | Modify (add deferred spell autocmd) |
| `init.lua` | Modify (remove dead requires, add perf settings) |

## Files NOT Touched

LSP servers, completion, telescope, treesitter, git plugins, colorscheme, flash, harpoon, conform, lualine, bufferline, noice, mini, neo-tree, lint.
