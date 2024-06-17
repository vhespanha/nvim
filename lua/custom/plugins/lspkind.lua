return {
  'onsails/lspkind-nvim',
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'

    cmp.setup {
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        expandable_indicator = true,
        format = lspkind.cmp_format {
          mode = 'symbol',
          symbol_map = { Copilot = '' },
          preset = 'codicons',
          maxwidth = 50,
          ellipsis_char = '...',
          show_labelDetails = true,
          before = function(entry, vim_item)
            return vim_item
          end,
        },
      },
    }
  end,
}
