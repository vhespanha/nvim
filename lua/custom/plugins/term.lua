return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      size = 67,
      open_mapping = [[<c-t>]], -- toggle terminal with Ctrl-t
      insert_mappings = true, -- open mapping applies in insert mode
      terminal_mappings = true, -- open mapping applies in the opened terminals
      start_in_insert = true,
      direction = 'vertical',
      autochdir = true,
      shade_terminals = false,
      float_opts = {
        border = 'curved',
        width = 100,
        height = 30,
      },
      highlights = {
        Normal = {
          guibg = '#0f0f0f',
        },
        NormalFloat = {
          link = 'Normal',
        },
        FloatBorder = {
          guifg = '#272727',
          guibg = '#0f0f0f',
        },
      },
    }

    -- Key mappings for opening specific terminals
    vim.api.nvim_set_keymap('n', '<leader>1', '<Cmd>1ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>2', '<Cmd>2ToggleTerm<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>3', '<Cmd>3ToggleTerm<CR>', { noremap = true, silent = true })

    -- Key mappings for splitting terminals
    vim.api.nvim_set_keymap(
      'n',
      '<leader>tv',
      '<Cmd>ToggleTerm direction=vertical<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>th',
      '<Cmd>ToggleTerm direction=horizontal<CR>',
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap('n', '<leader>tf', '<Cmd>ToggleTerm direction=float<CR>', { noremap = true, silent = true })

    -- Function to set terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-Left>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-Down>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-Up>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-Right>', [[<Cmd>wincmd l<CR>]], opts)
    end

    -- Apply terminal keymaps when a terminal is opened
    vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'
  end,
}
