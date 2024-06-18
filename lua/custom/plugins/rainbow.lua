return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    -- This module contains a number of default definitions

    require('rainbow-delimiters.setup').setup {
      highlight = {
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterViolet',
      },
    }
  end,
}
