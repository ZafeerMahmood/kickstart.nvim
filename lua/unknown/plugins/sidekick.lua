-- sidekick.nvim — AI coding assistant by folke
-- https://github.com/folke/sidekick.nvim
--
-- Currently using: CLI only (Claude Code terminal integration)
--
-- Keymaps:
--   <c-.>         global toggle (works in normal/insert/visual/terminal)
--   <leader>ac    toggle Claude terminal
--   <leader>af    focus the CLI window
--   <leader>ar    resume last session (/resume)
--   <leader>aR    continue session (/continue)
--   <leader>am    select model (/model)
--   <leader>ab    add current buffer to context ({file})
--   <leader>as    send visual selection ({selection}) [visual mode]
--   <leader>at    select which CLI tool to use
--   <leader>ap    select prompt template [normal + visual]
--   <leader>aa    accept NES diff (requires Copilot — currently disabled)
--   <leader>ad    dismiss NES diff (requires Copilot — currently disabled)
--
-- Config:
--   cli.watch=true  auto-reloads files modified by AI tools
--   right split, 80 cols wide
--   mux disabled (no tmux/zellij — Windows)
--   autoread + FocusGained->checktime = reload files changed externally
--
-- TODO: NES (Next Edit Suggestions) is disabled — no Copilot LSP installed.
--       NES provides inline edit suggestions powered by Copilot. To enable:
--         1. Install github/copilot.vim or copilot LSP
--         2. Run :Copilot auth (or :LspCopilotSignIn)
--         3. Uncomment NES keymaps below (<Tab>, <leader>aa, <leader>ad)
--         4. Uncomment nes opts section
--         5. Verify with :checkhealth sidekick

return {
  'folke/sidekick.nvim',
  keys = {
    -- NES: navigate/apply next edit suggestion (requires Copilot LSP)
    -- {
    --   '<tab>',
    --   function()
    --     if not require('sidekick').nes_jump_or_apply() then
    --       return '<Tab>'
    --     end
    --   end,
    --   expr = true,
    --   desc = 'Goto/Apply Next Edit Suggestion',
    -- },
    -- Toggle Claude terminal
    {
      '<leader>ac',
      function()
        require('sidekick.cli').toggle { name = 'claude' }
      end,
      desc = '[A]I [C]laude toggle',
    },
    -- Focus Claude terminal
    {
      '<leader>af',
      function()
        require('sidekick.cli').focus()
      end,
      desc = '[A]I [F]ocus Claude',
    },
    -- Resume session
    {
      '<leader>ar',
      function()
        require('sidekick.cli').show { name = 'claude' }
        vim.defer_fn(function()
          require('sidekick.cli').send { msg = '/resume' }
        end, 200)
      end,
      desc = '[A]I [R]esume session',
    },
    -- Continue session
    {
      '<leader>aR',
      function()
        require('sidekick.cli').show { name = 'claude' }
        vim.defer_fn(function()
          require('sidekick.cli').send { msg = '/continue' }
        end, 200)
      end,
      desc = '[A]I continue (cont[R]ol)',
    },
    -- Select model
    {
      '<leader>am',
      function()
        require('sidekick.cli').show { name = 'claude' }
        vim.defer_fn(function()
          require('sidekick.cli').send { msg = '/model' }
        end, 200)
      end,
      desc = '[A]I select [M]odel',
    },
    -- Add current buffer to context
    {
      '<leader>ab',
      function()
        require('sidekick.cli').send { msg = '{file}' }
      end,
      desc = '[A]I add [B]uffer to context',
    },
    -- Send visual selection
    {
      '<leader>as',
      function()
        require('sidekick.cli').send { msg = '{selection}' }
      end,
      mode = 'v',
      desc = '[A]I [S]end selection',
    },
    -- Accept NES diff (requires Copilot LSP)
    -- {
    --   '<leader>aa',
    --   function()
    --     require('sidekick.nes').apply()
    --   end,
    --   desc = '[A]I [A]ccept diff',
    -- },
    -- Deny NES diff (requires Copilot LSP)
    -- {
    --   '<leader>ad',
    --   function()
    --     require('sidekick.nes').clear()
    --   end,
    --   desc = '[A]I [D]eny diff',
    -- },
    -- Select which CLI tool to use (claude, gemini, codex, etc.)
    {
      '<leader>at',
      function()
        require('sidekick.cli').select()
      end,
      desc = '[A]I select [T]ool',
    },
    -- Select prompt template
    {
      '<leader>ap',
      function()
        require('sidekick.cli').prompt()
      end,
      mode = { 'n', 'x' },
      desc = '[A]I select [P]rompt',
    },
    -- Global toggle
    {
      '<c-.>',
      function()
        require('sidekick.cli').toggle()
      end,
      mode = { 'n', 't', 'i', 'x' },
      desc = 'Sidekick Toggle',
    },
  },
  opts = {
    -- NES disabled — uncomment when Copilot LSP is installed
    -- nes = {
    --   debounce = 100,
    --   diff = {
    --     inline = 'words',
    --   },
    -- },
    cli = {
      watch = true,
      win = {
        layout = 'right',
        split = {
          width = 80,
        },
      },
      mux = {
        enabled = false,
      },
    },
  },
  config = function(_, opts)
    require('sidekick').setup(opts)

    vim.o.autoread = true
    vim.api.nvim_create_autocmd({ 'FocusGained' }, {
      callback = function()
        vim.cmd('checktime')
      end,
    })
  end,
}
