-- Highlight function arguments using Treesitter
-- See: https://github.com/m-demare/hlargs.nvim

return {
  'm-demare/hlargs.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
  opts = {
    hl_priority = 120,
    excluded_filetypes = { 'DiffviewFiles', 'DiffviewFileHistory', 'diff' },
  },
}
