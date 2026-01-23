-- Quick-switch between frequently used files
-- See: https://github.com/ThePrimeagen/harpoon

return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require('harpoon')
    harpoon:setup()

    vim.keymap.set('n', '<leader>ma', function() harpoon:list():add() end, { desc = '[M]ark [A]dd file' })
    vim.keymap.set('n', '<leader>mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[M]ark menu' })

    -- Quick access to harpooned files
    vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon file 1' })
    vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon file 2' })
    vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon file 3' })
    vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon file 4' })
  end,
}
