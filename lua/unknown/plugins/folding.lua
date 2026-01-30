  -- Folding
  -- Uses treesitter for smart folding
  -- Standard vim fold commands: za (toggle), zc (close), zo (open), zM (close all), zR (open all)

  return {
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
  }

