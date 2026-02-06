-- Snacks.nvim utilities
-- See: https://github.com/folke/snacks.nvim

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  dependencies = { "MaximilianLloyd/ascii.nvim" },
  opts = function()
    local ascii = require('ascii')
    return {
      bigfile = { enabled = true, size = 1.5 * 1024 * 1024 },
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(ascii.art.cartoons.simpsons.homer_2, '\n'),
        keys = {
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
          { icon = ' ', key = 'c', desc = 'Config', action = ':e $MYVIMRC' },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header', align = 'center' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup', align = 'center' },
      },
    },
    }
  end,
}
