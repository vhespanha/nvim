return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        json = { 'jsonlint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        ['typescript.jsx'] = { 'eslintd_d' },
        ['javacript.jsx'] = { 'eslintd_d' },
        python = { 'flake8' },
        go = { 'golangcilint' },
      }

      local eslint_d = require('lint').linters.eslint_d
      eslint_d.args = {
        -- '--no-eslintrc',
        -- '--config',
        -- './eslintrc' -- path to global config
        '--format',
        'json',
        '--stdin',
        '--stdin-filename',
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          require('lint').try_lint()
        end,
      })
      -- print out running linters
      vim.api.nvim_create_user_command('PrintLintersInfo', function()
        local linters = require('lint').get_running()
        if #linters == 0 then
          return '󰦕'
        end
        -- using input to display message to pause so that the message can be read
        vim.fn.input { prompt = 'Linters currently running\n󱉶 ' .. table.concat(linters, ', ') }
      end, { nargs = 0 })
    end,
  },
}
