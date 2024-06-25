return {
  'onsails/lspkind-nvim',
  config = function()
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'

    -- Define the highlight group
    vim.cmd [[
      highlight! LspKindIcon guifg=#e6edf3
    ]]

    cmp.setup {
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        expandable_indicator = true,
        format = lspkind.cmp_format {
          mode = 'symbol',
          symbol_map = { Supermaven = '' },
          preset = 'codicons',
          maxwidth = 50,
          ellipsis_char = '...',
          show_label_details = true,
          before = function(entry, vim_item)
            vim_item.kind_hl_group = 'LspKindIcon'
            return vim_item
          end,
        },
      },
    }
  end,
}
