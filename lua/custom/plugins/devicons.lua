return {
  'nvim-tree/nvim-web-devicons',
  dependencies = {
    'rachartier/tiny-devicons-auto-colors.nvim',
    event = 'VeryLazy',
    config = function()
      require('tiny-devicons-auto-colors').setup {
        colors = {
          '#7d8590',
          '#58a6ff',
          '#3fb950',
          '#e3b341',
          '#f0883e',
          '#ff7b72',
          '#be8fff',
          '#f778ba',
          '#f78166',
        },
      }
    end,
  },
  config = function()
    require('nvim-web-devicons').setup {
      color_icons = true,
      override = {
        go = {
          icon = '',
          color = '#58a6ff',
          name = 'Go',
        },
      },
      react = {
        icon = '󰜈',
        color = '#58a6ff',
        name = 'React',
      },
    }
  end,
}
