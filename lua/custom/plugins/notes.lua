return {
  {
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
  },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- Optional, for search and quick-switch functionality
      'hrsh7th/nvim-cmp', -- Optional, for completion of note references
    },
    opts = function()
      local obsidian = require 'obsidian'

      local function generate_note_path(title)
        local date = os.date '%Y-%m-%d'
        local filename = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower() .. '-' .. date .. '.md'
        return filename
      end

      return {
        workspaces = {
          {
            name = 'notes',
            path = '~/Dropbox/notes',
          },
        },
        ui = {
          enable = false, -- Enable UI features
        },
        templates = {
          folder = 'templates',
          date_format = '%Y-%m-%d',
          time_format = '%H:%M',
        },
        mappings = {
          ['<leader>cn'] = {
            action = function()
              vim.ui.input({ prompt = 'Note Title: ' }, function(title)
                if title then
                  local current_dir = vim.fn.expand '%:p:h'
                  local note_path = current_dir .. '/' .. generate_note_path(title)
                  vim.cmd('edit ' .. note_path)
                end
              end)
            end,
            opts = { noremap = true, silent = true },
          },
          ['<leader>co'] = {
            action = function()
              vim.ui.input({ prompt = 'Note Title: ' }, function(title)
                if title then
                  local current_dir = vim.fn.expand '%:p:h'
                  local note_path = current_dir .. '/' .. generate_note_path(title)
                  vim.cmd('edit ' .. note_path)
                  vim.cmd '0r ~/Dropbox/notes/templates/courses.md'
                end
              end)
            end,
            opts = { noremap = true, silent = true },
          },
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        daily_notes = {
          folder = 'notes/dailies',
          date_format = '%Y-%m-%d',
          alias_format = '%B %-d, %Y',
          default_tags = { 'daily-notes' },
        },
        attachments = {
          img_folder = 'assets/imgs',
          img_name_func = function()
            return string.format('%s-', os.time())
          end,
          img_text_func = function(client, path)
            path = client:vault_relative_path(path) or path
            return string.format('![%s](%s)', path.name, path)
          end,
        },
        picker = {
          name = 'telescope.nvim',
          note_mappings = {
            new = '<C-x>',
            insert_link = '<C-l>',
          },
          tag_mappings = {
            tag_note = '<C-x>',
            insert_tag = '<C-l>',
          },
        },
        sort_by = 'modified',
        sort_reversed = true,
        search_max_lines = 1000,
        open_notes_in = 'current',
        callbacks = {
          post_setup = function(client) end,
          enter_note = function(client, note) end,
          leave_note = function(client, note) end,
          pre_write_note = function(client, note) end,
          post_set_workspace = function(client, workspace) end,
        },
      }
    end,
  },
}
