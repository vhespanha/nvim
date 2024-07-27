return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format {
            async = true,
            lsp_fallback = true,
          }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      -- Add new line to the end of the file
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'goimports', 'gofumpt' },
        javascript = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        typescript = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        typescriptreact = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        javacriptreact = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        ['typescript.jsx'] = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        ['javacript.jsx'] = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        svelte = { { 'prettier' }, 'eslintd_d' },
        yaml = { { 'prettierd', 'prettier' }, 'eslintd_d' },
        css = { { 'prettierd', 'prettier' } },
        sass = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' }, 'eslint_d' },
        python = { 'isort', 'black' },
        json = { 'prettier' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        toml = { 'taplo' },
        latex = { 'latexindent' },
        tex = { 'latexindent' },
      },
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format { bufnr = args.buf }
        end,
      }),
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
