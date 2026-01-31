-- Fuzzy Finder (files, LSP, etc)
-- See: https://github.com/nvim-telescope/telescope.nvim

return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'

    -- Center buffer after Telescope selection
    local center_after_select = function(prompt_bufnr)
      actions.select_default(prompt_bufnr)
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<CR>'] = center_after_select,
            ['<c-enter>'] = 'to_fuzzy_refine',
          },
          n = {
            ['<CR>'] = center_after_select,
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<C-p>', function()
      -- Common dependency directories to exclude
      local excludes = '.git node_modules venv env .venv .env __pycache__ .cache dist build vendor bower_components .tox .mypy_cache .pytest_cache target .cargo'
      local exclude_args = ''
      for dir in excludes:gmatch '%S+' do
        exclude_args = exclude_args .. ' --exclude ' .. dir
      end
      local cmd = string.format(
        '((fd --type f --hidden%s --path-separator /) + (fd --type f --no-ignore --extension md%s --path-separator /)) | Sort-Object -Unique',
        exclude_args,
        exclude_args
      )
      builtin.find_files {
        hidden = true,
        file_ignore_patterns = { '%.git[/\\]' },
        find_command = { 'powershell', '-NoProfile', '-Command', cmd },
      }
    end, { desc = 'Find Files (Ctrl+P)' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', function()
      builtin.grep_string {
        additional_args = { '--path-separator', '/' },
      }
    end, { desc = '[S]earch current [W]ord' })

    vim.keymap.set('n', '<C-g>', function()
      builtin.live_grep {
        additional_args = { '--path-separator', '/' },
      }
    end, { desc = '[S]earch by [G]rep' })

    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<C-f>', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
        additional_args = { '--path-separator', '/' },
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files {
        cwd = vim.fn.stdpath 'config',
        find_command = { 'fd', '--type', 'f', '--hidden', '--exclude', '.git', '--path-separator', '/' },
      }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
