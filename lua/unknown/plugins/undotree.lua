-- Visual undo history tree
-- See: https://github.com/mbbill/undotree

return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { '<leader>u', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo tree' },
  },
}
