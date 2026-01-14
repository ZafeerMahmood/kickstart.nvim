-- Folding: VSCode-like code folding with persistence
-- Uses treesitter for smart folding, saves fold state between sessions
-- Standard vim fold commands: za (toggle), zc (close), zo (open), zM (close all), zR (open all)

return {
  -- nvim-ufo: Modern folding with treesitter support
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufReadPost',
    init = function()
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    opts = {
      provider_selector = function(_, filetype, _)
        local indent_filetypes = { 'markdown', 'text', 'txt' }
        if vim.tbl_contains(indent_filetypes, filetype) then
          return { 'indent' }
        end
        return { 'treesitter', 'indent' }
      end,
    },
  },

  -- Persistence: Save and restore folds + cursor position
  {
    'folke/persistence.nvim',
    event = 'BufReadPre',
    opts = {},
    config = function(_, opts)
      require('persistence').setup(opts)

      -- Auto-save/load folds per file
      vim.api.nvim_create_autocmd('BufWinLeave', {
        group = vim.api.nvim_create_augroup('SaveFolds', { clear = true }),
        pattern = '*',
        callback = function()
          if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
            vim.cmd 'silent! mkview'
          end
        end,
      })

      vim.api.nvim_create_autocmd('BufWinEnter', {
        group = vim.api.nvim_create_augroup('LoadFolds', { clear = true }),
        pattern = '*',
        callback = function()
          if vim.bo.filetype ~= '' and vim.bo.buftype == '' then
            vim.cmd 'silent! loadview'
          end
        end,
      })
    end,
  },
}