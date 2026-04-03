-- Python virtual environment selector
-- Auto-discovers and activates venvs, remembers per-project
-- See: https://github.com/linux-cultist/venv-selector.nvim

local is_win = vim.fn.has('win32') == 1
-- . instead of / in regex — fd --full-path uses OS-native separators on Windows
local python_pattern = is_win and 'Scripts.python\\.exe$' or 'bin.python$'

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
      -- Default searches use Unix-only patterns; disable on Windows
      enable_default_searches = not is_win,
      -- Restart Python LSPs after venv activation so Jedi picks up venv packages (Django, DRF, etc.)
      on_venv_activate_callback = function()
        for _, name in ipairs({ 'pylsp', 'ruff' }) do
          for _, client in ipairs(vim.lsp.get_clients({ name = name })) do
            client:stop()
          end
        end
        -- wait for clients to fully shut down before restarting
        vim.defer_fn(function()
          vim.cmd('LspStart')
        end, 200)
      end,
    },
    search = {
      -- LSP workspace root — finds venvs in the actual python subproject (monorepo support)
      -- Paths quoted with single quotes to handle spaces (e.g. "C:\Users\First Last\...")
      workspace_venvs = {
        command = "fd " .. python_pattern .. " '$WORKSPACE_PATH' --full-path -a -I --max-depth 4",
      },
      -- CWD with depth — finds venvs in subdirectories when opened from monorepo root
      cwd_venvs = {
        command = "fd " .. python_pattern .. " '$CWD' --full-path -a -I --max-depth 5",
      },
    },
  },
}
