-- noice.nvim
-- github https://github.com/folke/noice.nvim
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      -- override markdown rendering for better hover/signature do
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    routes = {
      -- skip "written" messages
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    presets = {
      bottom_search = true, -- classic bottom cmdline for search
      long_message_to_split = true, -- long messages go to split
      lsp_doc_border = true, -- border on hover/signature docs
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
}
