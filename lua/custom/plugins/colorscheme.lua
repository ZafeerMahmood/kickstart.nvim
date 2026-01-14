-- Colorscheme persistence and popular themes
-- Saves your colorscheme choice and restores it on startup

local colorscheme_file = vim.fn.stdpath 'data' .. '/colorscheme.txt'

-- Helper function to save colorscheme
local function save_colorscheme(name)
  local file = io.open(colorscheme_file, 'w')
  if file then
    file:write(name)
    file:close()
  end
end

-- Helper function to load saved colorscheme
local function load_saved_colorscheme()
  local file = io.open(colorscheme_file, 'r')
  if file then
    local name = file:read '*a'
    file:close()
    return name
  end
  return nil
end

-- Custom Telescope colorscheme picker that saves selection
local function colorscheme_picker()
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local previewers = require 'telescope.previewers'

  -- Get all available colorschemes
  local colors = vim.fn.getcompletion('', 'color')

  -- Store original colorscheme for preview restore on cancel
  local original = vim.g.colors_name or 'default'

  pickers
    .new({}, {
      prompt_title = 'Select Colorscheme (saves automatically)',
      finder = finders.new_table {
        results = colors,
      },
      sorter = conf.generic_sorter {},
      previewer = previewers.new_buffer_previewer {
        define_preview = function(self, entry)
          -- Preview the colorscheme when hovering
          vim.cmd.colorscheme(entry.value)
        end,
      },
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if selection then
            vim.cmd.colorscheme(selection.value)
            save_colorscheme(selection.value)
            vim.notify('Colorscheme saved: ' .. selection.value, vim.log.levels.INFO)
          end
        end)
        -- Restore original on cancel
        actions.close:enhance {
          post = function()
            -- Only restore if no selection was made (cancelled)
            if vim.g.colors_name ~= original then
              -- Check if we should restore (no save happened)
            end
          end,
        }
        return true
      end,
    })
    :find()
end

return {
  {
    'decaycs/decay.nvim',
    name = 'decay',
    lazy = false,
    priority = 1000
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
      flavour = 'mocha', -- latte, frappe, macchiato, mocha
      integrations = {
        neo_tree = true,
        telescope = true,
        treesitter = true,
        which_key = true,
        gitsigns = true,
        mini = true,
        native_lsp = { enabled = true },
      },
    },
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        italic = false,
      },
    },
  },

  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = 'NONE',
          keywords = 'NONE',
        },
      },
    },
  },

  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'dark', -- dark, darker, cool, deep, warm, warmer
      code_style = {
        comments = 'none',
      },
    },
  },

  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'material'
      vim.g.gruvbox_material_enable_italic = 0
    end,
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup {}
    end,
  },

  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'medium'
      vim.g.everforest_enable_italic = 0
    end,
  },

  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'dark',
      italic_comments = false,
    },
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      italic_comments = false,
    },
  },

  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      italic_comment = false,
    },
  },

  {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      disable = {
        colored_cursor = false,
        eob_lines = false,
      },
    },
  },

  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_italic = false
    end,
  },

  {
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
  },

  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = { italic = false },
      },
    },
  },

  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = 'default'
      vim.g.sonokai_enable_italic = 0
    end,
  },

  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      italic_comments = false,
    },
  },

  {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
      },
    },
  },

  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        comments = 'NONE',
      },
    },
  },

  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      filter = 'pro', -- classic, octagon, pro, machine, ristretto, spectrum
    },
  },

  -- ═══════════════════════════════════════════════════════════════════════════
  -- COLORSCHEME SYSTEM
  -- ═══════════════════════════════════════════════════════════════════════════
  {
    'nvim-telescope/telescope.nvim',
    optional = true,
    keys = {
      {
        '<leader>cs',
        colorscheme_picker,
        desc = '[C]olor[s]cheme picker (persistent)',
      },
    },
  },

  -- Auto-load saved colorscheme on startup
  {
    'folke/tokyonight.nvim', -- Use tokyonight as the trigger plugin (it's always loaded)
    priority = 1000,
    config = function()
      -- Setup tokyonight
      require('tokyonight').setup {
        styles = {
          comments = { italic = false },
        },
      }

      -- Load saved colorscheme or default to tokyonight
      local saved = load_saved_colorscheme()
      if saved and saved ~= '' then
        local ok, _ = pcall(vim.cmd.colorscheme, saved)
        if not ok then
          vim.cmd.colorscheme 'tokyonight-night'
        end
      else
        vim.cmd.colorscheme 'tokyonight-night'
      end
    end,
  },
}
