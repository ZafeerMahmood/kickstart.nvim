-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Lazygit: Full git UI inside nvim
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Open LazyGit' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit current file history' },
    },
    config = function()
      -- Let lazygit handle its own keybindings natively
      -- q = quit lazygit, Esc = go back from current view
      -- No overrides needed - lazygit's defaults work well
    end,
  },

  -- Toggleterm: Better integrated terminal
  {
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
  },

  -- Diffview: Side-by-side git diffs
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = '[G]it [d]iff view' },
      { '<leader>gD', '<cmd>DiffviewFileHistory %<cr>', desc = '[G]it file history [D]iff' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = '[G]it diff [q]uit' },
    },
    config = function()
      local actions = require 'diffview.actions'
      require('diffview').setup {
        keymaps = {
          view = { q = actions.close },
          file_panel = { q = actions.close },
          file_history_panel = { q = actions.close },
        },
      }
    end,
  },

  -- Comment.nvim: Toggle comments with gcc
  {
    'numToStr/Comment.nvim',
    opts = {},
    keys = {
      { 'gcc', mode = 'n', desc = 'Toggle comment line' },
      { 'gc', mode = { 'n', 'v' }, desc = 'Toggle comment' },
    },
  },

  -- Bufferline: VS Code-like tabs at the top
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'thin',
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        -- Show a dot for modified/unsaved buffers
        indicator = {
          style = 'icon',
          icon = ' ',
        },
        modified_icon = '●', -- dot for unsaved changes
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'center',
            separator = true,
          },
        },
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Keymaps for switching buffers
      vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<leader>x', function()
        local buf_to_close = vim.api.nvim_get_current_buf()
        vim.cmd('BufferLineCyclePrev')
        vim.cmd('bdelete ' .. buf_to_close)
      end, { desc = 'Close buffer' })
    end,
  },

  -- hlargs.nvim: Highlight function arguments using Treesitter
  {
    'm-demare/hlargs.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = 'BufRead',
    opts = {
      hl_priority = 120,
      excluded_argnames = {
        usages = {
          lua = { 'self' },
          python = { 'self', 'cls' },
        },
      },
    },
  },

  -- Claude Code: AI-powered coding assistant inside Neovim
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
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
          env = { SHELL = 'pwsh' },
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
          local bufname = vim.api.nvim_buf_get_name(0)
          local buftype = vim.bo.buftype
          -- Detect claudecode diff buffers (contain "proposed" or are acwrite type)
          if bufname:match('proposed') or bufname:match('NEW FILE') or buftype == 'acwrite' then
            vim.schedule(function()
              vim.cmd('stopinsert')
            end)
          end
        end,
      })
    end,
  },
}

