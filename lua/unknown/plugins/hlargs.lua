-- Highlight function arguments using Treesitter
-- See: https://github.com/m-demare/hlargs.nvim
-- NOTE: Commented out — treesitter already highlights args. Re-enable if you miss it.

-- return {
--   'm-demare/hlargs.nvim',
--   dependencies = { 'nvim-treesitter/nvim-treesitter' },
--   event = 'BufRead',
--   opts = {
--     hl_priority = 120,
--     excluded_filetypes = { 'DiffviewFiles', 'DiffviewFileHistory', 'diff' },
--   },
-- }

return {}
