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
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        javacriptreact = { 'prettierd' },
        ['typescript.jsx'] = { 'prettierd' },
        ['javacript.jsx'] = { 'prettierd' },
        svelte = { 'prettier' },
        yaml = { 'prettierd' },
        css = { 'prettierd', 'stylelint' },
        sass = { 'prettierd', 'stylelint' },
        scss = { 'prettierd', 'stylelint' },
        html = { 'prettierd' },
        python = { 'isort', 'black' },
        json = { 'prettierd' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        toml = { 'taplo' },
        latex = { 'latexindent' },
        tex = { 'latexindent' },
        markdown = { 'prettierd' },
        gotmpl = { 'prettier' },
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
