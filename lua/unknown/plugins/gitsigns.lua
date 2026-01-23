-- Git signs in the gutter and utilities for managing changes
-- NOTE: Keymaps are added by kickstart/plugins/gitsigns.lua
-- See: https://github.com/lewis6991/gitsigns.nvim

return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '│' },
      topdelete = { text = '│' },
      changedelete = { text = '~' },
    },
  },
}
