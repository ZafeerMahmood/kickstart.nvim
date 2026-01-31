-- AI-powered coding assistant inside Neovim
-- See: https://github.com/coder/claudecode.nvim

return {
  'coder/claudecode.nvim',
  keys = {
    { '<leader>ac', '<cmd>ClaudeCode<cr>', mode = { 'n' }, desc = '[A]I [C]laude toggle' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', mode = { 'n' }, desc = '[A]I [F]ocus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = '[A]I [R]esume session' },
    { '<leader>aR', '<cmd>ClaudeCode --continue<cr>', desc = '[A]I continue (cont[R]ol)' },
    { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = '[A]I select [M]odel' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = '[A]I add [B]uffer to context' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = '[A]I [S]end selection' },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = '[A]I [A]ccept diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = '[A]I [D]eny diff' },
  },
  opts = {
    terminal = {
      split_side = 'right',
      split_width_percentage = 0.40,
      snacks_win_opts = {
        env = { SHELL = 'cmd' }, --WARN: try with "pwsh" or "pwsh -NoProfile"
      },
    },
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = false,
      open_in_current_tab = false,
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)
    -- Force normal mode when entering claudecode diff buffers
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      callback = function()
        local buftype = vim.bo.buftype
        if buftype == '' then return end
        if buftype == 'acwrite' then
          vim.schedule(function()
            vim.cmd('stopinsert')
          end)
        end
      end,
    })

    -- Auto-reload buffers when files change on disk (after diff accept/deny)
    vim.o.autoread = true
    vim.api.nvim_create_autocmd({ 'FocusGained' }, {
      callback = function()
        vim.cmd('checktime')
      end,
    })
  end,
}
