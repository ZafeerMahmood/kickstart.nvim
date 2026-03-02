-- Core autocommands
-- Extracted from init.lua — autocommands and filetype additions

-- Ensure .mjs and other JS variants are recognized correctly
vim.filetype.add {
  extension = {
    mjs = 'javascript',
    cjs = 'javascript',
  },
}

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
