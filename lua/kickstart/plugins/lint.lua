return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Configure linters by filetype
      -- NOTE: ESLint is handled by eslint LSP (provides diagnostics + code actions like VSCode)
      -- NOTE: Python ruff is handled by ruff LSP (provides diagnostics + code actions)
      -- nvim-lint is only used for linters without LSP support
      lint.linters_by_ft = {
        -- Add non-LSP linters here if needed
        -- markdown = { 'markdownlint' },
      }

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })

      -- :FixLint command - Fix auto-fixable lint issues explicitly
      -- Uses ESLint LSP for JS/TS (source.fixAll.eslint)
      -- Uses Ruff LSP for Python (source.fixAll.ruff)
      vim.api.nvim_create_user_command('FixLint', function()
        local ft = vim.bo.filetype

        -- JavaScript/TypeScript - Use ESLint LSP code action
        if ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact' then
          vim.lsp.buf.code_action {
            context = { only = { 'source.fixAll.eslint' } },
            apply = true,
          }
          vim.notify('ESLint: Fixing all auto-fixable issues...', vim.log.levels.INFO)

        -- Python - Use Ruff LSP code action
        elseif ft == 'python' then
          vim.lsp.buf.code_action {
            context = { only = { 'source.fixAll.ruff' } },
            apply = true,
          }
          vim.notify('Ruff: Fixing all auto-fixable issues...', vim.log.levels.INFO)
        else
          vim.notify('No lint fixer for filetype: ' .. ft, vim.log.levels.WARN)
        end
      end, { desc = 'Fix auto-fixable lint issues (ESLint/Ruff)' })

      -- :OrganizeImports command for JS/TS and Python
      vim.api.nvim_create_user_command('OrganizeImports', function()
        local ft = vim.bo.filetype
        if ft == 'javascript' or ft == 'javascriptreact' or ft == 'typescript' or ft == 'typescriptreact' then
          -- TypeScript/ESLint organize imports
          vim.lsp.buf.code_action {
            context = { only = { 'source.organizeImports' } },
            apply = true,
          }
        elseif ft == 'python' then
          -- Ruff organize imports
          vim.lsp.buf.code_action {
            context = { only = { 'source.organizeImports.ruff' } },
            apply = true,
          }
        end
      end, { desc = 'Organize imports' })

      -- Keymaps
      vim.keymap.set('n', '<leader>lf', '<cmd>FixLint<CR>', { desc = '[L]int [F]ix all auto-fixable' })
      vim.keymap.set('n', '<leader>lo', '<cmd>OrganizeImports<CR>', { desc = '[L]int [O]rganize imports' })
    end,
  },
}