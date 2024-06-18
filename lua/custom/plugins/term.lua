return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      open_mapping = [[<c-t>]], -- toggle terminal with Ctrl-t
      insert_mappings = true, -- open mapping applies in insert mode
      terminal_mappings = true, -- open mapping applies in the opened terminals
      direction = 'float',
      autochdir = true,
      float_opts = {
        border = 'curved',
        width = 100,
        height = 50,
        winblend = 10,
      },
      highlights = {
        FloatBorder = {
          guifg = '#272727',
          guibg = '#0f0f0f',
        },
      },
    }
  end,
}
