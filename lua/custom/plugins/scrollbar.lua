return {
  'petertriho/nvim-scrollbar',
  config = function()
    require('scrollbar').setup {
      show_in_active_only = true,
      hide_if_all_visible = false, -- Hides everything if all lines are visible
      handle = {
        text = ' ',
        blend = 10, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        highlight = 'CursorColumn',
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
      excluded_buftypes = {
        'terminal',
      },
      handlers = {
        cursor = false,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
      },
    }
  end,
}
