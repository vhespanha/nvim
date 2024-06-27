return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'mhinz/vim-sayonara',
    {
      'axkirillov/hbac.nvim',
      config = function()
        require('hbac').setup {
          autoclose = true, -- set autoclose to false if you want to close manually
          threshold = 10, -- hbac will start closing unedited buffers once that number is reached
          close_command = function(bufnr)
            vim.api.nvim_buf_delete(bufnr, {})
          end,
        }
      end,
    },
  },

  config = function()
    local harpoon = require 'harpoon'
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    local action_state = require 'telescope.actions.state'
    local themes = require 'telescope.themes'

    harpoon:setup()

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      local opts = themes.get_dropdown {
        prompt_title = 'Harpoon',
        finder = require('telescope.finders').new_table {
          results = file_paths,
        },
        previewer = false,
        sorter = require('telescope.config').values.generic_sorter {},
        attach_mappings = function(prompt_bufnr, map)
          map('i', '<CR>', function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            vim.cmd('edit ' .. selection.value)
          end)
          return true
        end,
      }

      require('telescope.pickers').new({}, opts):find()
    end

    local hbac = require 'hbac'

    local last_buffer = nil
    local current_buffer = vim.api.nvim_get_current_buf()

    -- Autocommand to track buffer changes
    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        last_buffer = current_buffer
        current_buffer = vim.api.nvim_get_current_buf()
      end,
    })

    -- Function to switch to the last visited buffer
    function switch_to_last_buffer()
      if last_buffer and vim.api.nvim_buf_is_valid(last_buffer) then
        vim.api.nvim_set_current_buf(last_buffer)
      else
        print 'No valid last buffer to switch to'
      end
    end

    -- Map Ctrl+Tab to switch to the last visited buffer
    vim.api.nvim_set_keymap('n', '<C-Tab>', ':lua switch_to_last_buffer()<CR>', { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
      hbac.toggle_pin()
    end, { desc = '[E]nter buffer to Harpoon' })

    vim.keymap.set('n', '<leader>q', function()
      harpoon:list():remove()
      hbac.toggle_pin()
    end, { desc = '[Q]uit from harpoon' })

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })

    -- Generate mappings
    local listmappings = {}
    for i = 1, 9 do
      local key = '' .. tostring(i)
      listmappings[key] = function()
        harpoon:list():select(i)
      end
    end

    -- Apply mappings
    for key, action in pairs(listmappings) do
      vim.keymap.set('n', key, action)
    end
  end,
}
