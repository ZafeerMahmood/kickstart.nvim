-- Python virtual environment selector
-- Auto-discovers and activates venvs, remembers per-project
-- See: https://github.com/linux-cultist/venv-selector.nvim

return {
  'linux-cultist/venv-selector.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  ft = 'python',
  cmd = { 'VenvSelect', 'VenvSelectCache' },
  keys = {
    { '<leader>vs', '<cmd>VenvSelect<cr>', desc = '[V]env [S]elect' },
  },
  opts = {
    options = {
      notify_user_on_venv_activation = true,
    },
  },
}
