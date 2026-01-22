-- UI Polish plugins
-- supported by unknown-decay theme

return {
  -- rainbow delimiters: colorize matching brackets/parentheses/braces
  -- colors provided by unknown-decay theme
  {
    'hiphish/rainbow-delimiters.nvim',
    event = 'bufreadpost',
  },

  -- lualine: feature-rich statusline (replaces mini.statusline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- alpha-nvim: dashboard/startup screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'vimenter',
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        '                                                                              ',
        '  ██╗   ██╗███╗   ██╗██╗  ██╗███╗   ██╗ ██████╗ ██╗    ██╗███╗   ██╗          ',
        '  ██║   ██║████╗  ██║██║ ██╔╝████╗  ██║██╔═══██╗██║    ██║████╗  ██║          ',
        '  ██║   ██║██╔██╗ ██║█████╔╝ ██╔██╗ ██║██║   ██║██║ █╗ ██║██╔██╗ ██║          ',
        '  ██║   ██║██║╚██╗██║██╔═██╗ ██║╚██╗██║██║   ██║██║███╗██║██║╚██╗██║          ',
        '  ╚██████╔╝██║ ╚████║██║  ██╗██║ ╚████║╚██████╔╝╚███╔███╔╝██║ ╚████║          ',
        '   ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝          ',
        '          ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                  ',
        '          ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                  ',
        '          ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                  ',
        '          ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                  ',
        '          ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                  ',
        '          ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                  ',
      }
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      -- dashboard.section.footer.opts.hl = "AlphaFooter"

      dashboard.section.buttons.val = {
          dashboard.button('f', 'Find File        Ctrl+p', ':Telescope find_files<cr>'),
          dashboard.button('r', 'Recent Files     <leader>s.', ':Telescope oldfiles<cr>'),
          dashboard.button('g', 'Find Text        Ctrl+g', ':Telescope live_grep<cr>'),
          dashboard.button('c', 'Configuration    $MYVIMRC', ':e $MYVIMRC<cr>'),
          dashboard.button('l', 'Lazy             :Lazy', ':Lazy<cr>'),
          dashboard.button('q', 'Quit             :Exit', ':qa<cr>'),
      }


      -- dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.config)

      vim.api.nvim_create_autocmd('filetype', {
        pattern = 'alpha',
        callback = function()
          vim.opt_local.foldenable = false
          vim.cmd('setlocal winhighlight=Normal:AlphaNormal')
        end,
      })
    end,
  },
  -- flash.nvim: fast navgation - jump anywhere with 2-3 keystrokes
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash jump' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash treesitter' },
    },
  },

  -- harpoon: quick-switch between frequently used files
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      vim.keymap.set('n', '<leader>ma', function() harpoon:list():add() end, { desc = '[m]ark [a]dd file' })
      vim.keymap.set('n', '<leader>mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[m]ark menu' })

      -- quick access to harpooned files
      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'harpoon file 1' })
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'harpoon file 2' })
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'harpoon file 3' })
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'harpoon file 4' })
    end,
  },
}
