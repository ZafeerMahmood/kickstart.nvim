-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<C-b>', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    close_if_last_window = true,
    window = {
      width = 30,
      mappings = {
        ['<C-b>'] = 'close_window',
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          '.git',
        },
      },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = false, -- NOTE: change this to true if you need latest changes in neo-tree
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)

    -- Auto-open neo-tree when opening Neovim with a directory
    -- Don't auto-open when no files given (alpha dashboard will show instead)
    -- vim.api.nvim_create_autocmd('VimEnter', {
    --   callback = function()
    --     if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
    --       vim.cmd('Neotree show')
    --     end
    --   end,
    -- })
    --
    -- Open neo-tree when leaving alpha dashboard
    -- vim.api.nvim_create_autocmd('User', {
    --   pattern = 'AlphaReady',
    --   callback = function()
    --     vim.api.nvim_create_autocmd('BufUnload', {
    --       buffer = 0,
    --       once = true,
    --       callback = function()
    --         vim.schedule(function()
    --           vim.cmd('Neotree show')
    --         end)
    --       end,
    --     })
    --   end,
    -- })
  end,
}
