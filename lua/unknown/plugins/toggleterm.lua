-- Better integrated terminal
-- See: https://github.com/akinsho/toggleterm.nvim

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 15,
    open_mapping = [[<C-\>]],
    direction = 'float',
    shade_terminals = true,
    shading_factor = 2,
    persist_size = true,
    close_on_exit = true,
  },
  event = 'VeryLazy',
}
