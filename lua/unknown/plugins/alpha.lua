-- Dashboard/startup screen
-- See: https://github.com/goolord/alpha-nvim

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
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
    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'

    dashboard.section.buttons.val = {
      dashboard.button('f', 'Find File        Ctrl+p', ':Telescope find_files<cr>'),
      dashboard.button('r', 'Recent Files     <leader>s.', ':Telescope oldfiles<cr>'),
      dashboard.button('g', 'Find Text        Ctrl+g', ':Telescope live_grep<cr>'),
      dashboard.button('c', 'Configuration    $MYVIMRC', ':e $MYVIMRC<cr>'),
      dashboard.button('l', 'Lazy             :Lazy', ':Lazy<cr>'),
      dashboard.button('q', 'Quit             :Exit', ':qa<cr>'),
    }

    alpha.setup(dashboard.config)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'alpha',
      callback = function()
        vim.opt_local.foldenable = false
        vim.cmd('setlocal winhighlight=Normal:AlphaNormal')
      end,
    })
  end,
}
