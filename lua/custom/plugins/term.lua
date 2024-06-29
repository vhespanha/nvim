return {
  'akinsho/toggleterm.nvim',
  dependencies = {
    'willothy/flatten.nvim',
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
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
        width = 160,
        height = 50,
      },
      highlights = {
        FloatBorder = {
          guifg = '#272727',
          guibg = '#0f0f0f',
        },
      },
    }
    -- Additional check to ensure the key mapping is set correctly
    vim.api.nvim_set_keymap('n', '<c-t>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '<c-t>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<c-t>', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
  end,
}
