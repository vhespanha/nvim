return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    -- This module contains a number of default definitions
    local rainbow_delimiters = require 'rainbow-delimiters'
    require('rainbow-delimiters.setup').setup {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        html = rainbow_delimiters.strategy['local'],
      },
      highlight = {
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        'RainbowDelimiterPink',
      },
    }
  end,
}
