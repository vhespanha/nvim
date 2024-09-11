return {
  'HiPhish/rainbow-delimiters.nvim',
  config = function()
    require('rainbow-delimiters.setup').setup {
      highlight = {
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        'RainbowDelimiterPink',
      },
    }
  end,
}
