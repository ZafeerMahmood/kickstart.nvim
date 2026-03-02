-- Project navigation
-- Auto-detects and remembers projects, browse with Telescope

return {
  'ahmedkhalf/project.nvim',
  config = function()
    require('project_nvim').setup {
      detection_methods = { 'pattern', 'lsp' },
      patterns = { '.git', 'package.json', 'Cargo.toml', 'go.mod', '.sln' },
    }
    require('telescope').load_extension 'projects'
  end,
  keys = {
    { '<leader>pp', '<cmd>Telescope projects<cr>', desc = '[P]roject [P]icker' },
  },
}
