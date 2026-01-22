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
    'ZafeerMahmood/unknown-decay.nvim',
    name = 'unknown-decay',
    lazy = false,
    priority = 1000,
    config = function()
      require('unknown-decay').setup {
        transparent = false,
        italics = {
          comments = true,
          keywords = false,
          parameters = true,
          strings = false,
          variables = false,
        },
      }
    end,
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true, -- Load on-demand when selected via <leader>cs
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
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true, -- Load on-demand when selected via <leader>cs
    priority = 1000,
    opts = {
      variant = 'auto', -- auto, main, moon, dawn
      styles = {
        italic = false,
      },
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

      -- Load saved colorscheme or default to unknown-decay
      local saved = load_saved_colorscheme()
      if saved and saved ~= '' then
        local ok, _ = pcall(vim.cmd.colorscheme, saved)
        if not ok then
          vim.cmd.colorscheme 'unknown-decay'
        end
      else
        vim.cmd.colorscheme 'unknown-decay'
      end
    end,
  },
}
