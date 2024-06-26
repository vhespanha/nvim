return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },

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

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = '[A]dd to Harpoon' })

    vim.keymap.set('n', '<leader>q', function()
      harpoon:list():remove()
    end, { desc = '[Q]uit from harpoon' })

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })

    -- Generate mappings
    local mappings = {}
    for i = 1, 9 do
      local key = '' .. tostring(i)
      mappings[key] = function()
        harpoon:list():select(i)
      end
    end

    -- Apply mappings
    for key, action in pairs(mappings) do
      vim.keymap.set('n', key, action)
    end
  end,
}
