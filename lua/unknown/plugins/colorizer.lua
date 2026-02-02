return {
  "norcalli/nvim-colorizer.lua",
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" },
  config = function()
    require('colorizer').setup({
      "*",
      css = { rgb_fn = true },
    })
  end,
}
