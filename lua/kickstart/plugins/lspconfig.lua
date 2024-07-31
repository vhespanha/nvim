return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
      {
        'zeioth/garbage-day.nvim',
        event = 'VeryLazy',
        opts = {},
      },
    },
    config = function()
      -- Define the on_attach function
      local function on_attach(client, bufnr)
        -- Existing on_attach setup...

        -- Define the check_codelens_support function
        local function check_codelens_support()
          local clients = vim.lsp.get_active_clients { bufnr = 0 }
          for _, c in ipairs(clients) do
            if c.server_capabilities.codeLensProvider then
              return true
            end
          end
          return false
        end

        -- Create autocommands for Code Lens
        vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave', 'CursorHold', 'LspAttach', 'BufEnter' }, {
          buffer = bufnr,
          callback = function()
            if check_codelens_support() then
              vim.lsp.codelens.refresh { bufnr = 0 }
            end
          end,
        })

        -- Trigger Code Lens refresh
        vim.api.nvim_exec_autocmds('User', { pattern = 'LspAttached' })

        -- Setup Markdown Oxide daily note commands
        if client.name == 'markdown_oxide' then
          vim.api.nvim_create_user_command('Daily', function(args)
            local input = args.args
            vim.lsp.buf.execute_command { command = 'jump', arguments = { input } }
          end, { desc = 'Open daily note', nargs = '*' })
        end

        -- Key mappings for LSP
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = bufnr,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf,
              }
            end,
          })
        end

        if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, '[T]oggle Inlay [H]ints')
        end
      end

      -- Modify capabilities as per the requirements
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      capabilities.workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      }

      -- Setup markdown_oxide with the modified capabilities
      require('lspconfig').markdown_oxide.setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      local servers = {
        clangd = {},
        pyright = {},
        rust_analyzer = {},
        tsserver = {},
        templ = {},
        tailwindcss = {},
        sqls = {},
        jsonls = {
          format = {
            enable = true,
            indent = {
              tabSize = 2,
              insertSpaces = true,
            },
          },
        },
        htmx = {},
        html = {},
        staticcheck = {},
        proselint = {},
        eslint_d = {},
        prettierd = {},
        harper_ls = {
          filetypes = { 'markdown', 'txt', 'latex' },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        },
      }

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
