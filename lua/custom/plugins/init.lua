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
  },

 -- Toggleterm: Better integrated terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 15,
      open_mapping = [[<C-\>]],
      direction = 'horizontal',
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
      -- Keymaps for switching buffers (like Ctrl+Tab in VS Code)
      vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
      vim.keymap.set('n', '<leader>x', function()
        local buf_to_close = vim.api.nvim_get_current_buf()
        vim.cmd('BufferLineCyclePrev')
        vim.cmd('bdelete ' .. buf_to_close)
      end, { desc = 'Close buffer' })
    end,
  },
}

