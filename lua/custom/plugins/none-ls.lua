return {
  'nvimtools/none-ls.nvim',
  depenencies = {
    'nvimtools/none-ls-extras.nvim',
    'zeioth/none-ls-external-sources.nvim',
  },

  opts = {
    external_sources = {
      'none-ls-external-sources.diagnostics.eslint_d',
      'none-ls-external-sources.diagnostics.flake8',
      'none-ls-external-sources.formatting.eslint_d',
      'none-ls-external-sources.code_actions.eslint_d',
    },
  },

  config = function()
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.diagnostics.proselint,
        null_ls.builtins.diagnostics.staticcheck,
      },
    }
  end,
}
