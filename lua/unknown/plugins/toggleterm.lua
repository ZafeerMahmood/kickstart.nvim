-- Better integrated terminal
-- See: https://github.com/akinsho/toggleterm.nvim

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 15,
    open_mapping = [[<C-\>]],
    direction = 'horizontal',
    shell = 'pwsh -NoLogo',
    shade_terminals = true,
    shading_factor = 2,
    persist_size = true,
    close_on_exit = true,
  },
  keys = {
    { '<C-\\>', desc = 'Toggle terminal' },
    { '<leader>tt', '<cmd>ToggleTerm direction=float<cr>', desc = '[T]erminal floa[t]' },
  },
}
