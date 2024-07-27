return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- Set Evince as the PDF viewer
    vim.g.vimtex_view_general_viewer = 'evince'

    -- Configure the options to open the correct page and reuse the same instance
    vim.g.vimtex_view_general_options = '--unique file:@pdf'
  end,
}
