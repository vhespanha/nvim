return {
  'simonmclean/triptych.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require('triptych').setup {
      mappings = {
        -- Everything below is buffer-local, meaning it will only apply to Triptych windows
        show_help = 'g?',
        jump_to_cwd = '.', -- Pressing again will toggle back
        nav_left = { 'h', '<Left>', '<BS>' },
        nav_right = { 'l', '<Right>', '<CR>' },
        open_hsplit = { '-' },
        open_vsplit = { '|' },
        open_tab = { '<C-t>' },
        cd = '<leader>cd',
        delete = 'd',
        add = 'a',
        copy = 'c',
        rename = 'r',
        cut = 'x',
        paste = 'p',
        quit = 'q',
        toggle_hidden = '<leader>.',
      },
      options = {
        dirs_first = true,
        show_hidden = false,
        line_numbers = {
          enabled = false,
        },
        file_icons = {
          directory_icon = '',
          fallback_file_icon = '',
        },
        responsive_column_widths = {
          -- Keys are breakpoints, values are column widths
          -- A breakpoint means "when vim.o.columns >= x, use these column widths"
          -- Columns widths must add up to 1 after rounding to 2 decimal places
          -- Parent or child windows can be hidden by setting a width of 0
          ['0'] = { 0, 0.5, 0.5 },
          ['120'] = { 0, 0.25, 0.75 },
          ['200'] = { 0, 0.25, 0.75 },
        },
        backdrop = 100, -- Backdrop opacity. 0 is fully opaque, 100 is fully transparent (disables the feature)
        border = 'rounded', -- See :h nvim_open_win for border options
      },
      diagnostic_signs = {
        enabled = true,
      },
    }
  end,
  vim.keymap.set('n', '<leader>fb', ':Triptych<CR>', { silent = true }),
}
