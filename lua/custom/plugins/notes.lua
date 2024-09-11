return {
  'MeanderingProgrammer/markdown.nvim',
  main = 'render-markdown',
  opts = {},
  name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  config = function()
    require('render-markdown').setup {
      headings = {
        sign = false,
        width = 'block',
        signs = { '' },
      },
      code = {
        sign = false,
        style = 'language',
        width = 'block',
        border = 'thin',
        above = '',
        below = '',
      },
      quote = {
        icon = '|',
      },
      sign = {
        enabled = false,
      },
    }
  end,
}
