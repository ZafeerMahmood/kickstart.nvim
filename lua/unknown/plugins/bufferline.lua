-- VS Code-like tabs at the top
-- See: https://github.com/akinsho/bufferline.nvim

return {
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
}
