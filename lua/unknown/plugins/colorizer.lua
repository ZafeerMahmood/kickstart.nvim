return {
  'NvChad/nvim-colorizer.lua',
  cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
  event = 'BufReadPre',
  opts = {
    filetypes = { '*' },
    user_default_options = {
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      tailwind = true,
      mode = 'background',
    },
  },
}
