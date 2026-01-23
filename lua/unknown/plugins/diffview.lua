-- Side-by-side git diffs
-- See: https://github.com/sindrets/diffview.nvim

return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [d]iff view' },
    { '<leader>gD', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file history [D]iff' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = '[G]it diff [q]uit' },
  },
  config = function()
    local actions = require 'diffview.actions'
    require('diffview').setup {
      keymaps = {
        view = { q = actions.close },
        file_panel = { q = actions.close },
        file_history_panel = { q = actions.close },
      },
    }
  end,
}
