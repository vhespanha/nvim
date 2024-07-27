return {
  'zbirenbaum/copilot.lua',
  dependencies = {
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
    {
      'jonahgoldwastaken/copilot-status.nvim',
      lazy = true,
      event = 'BufReadPost',
      config = function()
        require('copilot_status').setup {
          icons = {
            idle = '',
            error = '',
            offline = '',
            warning = '',
            loading = '',
          },
          debug = false,
        }
      end,
    },
  },
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
        auto_refresh = true,
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = false,
        auto_trigger = true,
        debounce = 75,
      },
    }
  end,
}
