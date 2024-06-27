-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Git keymaps
vim.api.nvim_set_keymap('n', '<leader>ga', ':!git add .<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<Leader>gC', function()
  require('tinygit').smartCommit()
end, { desc = '[G]it [C]ommit' })

vim.keymap.set('n', '<Leader>gc', function()
  require('telescope').extensions.conventional_commits.conventional_commits()
end, { desc = '[G]it Conventional [C]ommit' })

vim.keymap.set('n', '<Leader>gp', function()
  require('tinygit').push()
end, { desc = '[G]it [P]ush' })

vim.keymap.set('n', '<leader>pr', function()
  require('tinygit').createGitHubPr()
end, { desc = 'Create [P]ull [R]equest' })

-- Replace tokens in the current buffer
vim.api.nvim_set_keymap('n', '<leader>rr', [[:lua ReplaceTokens()<CR>]], { noremap = true, silent = true })
function ReplaceTokens()
  local search = vim.fn.input 'Search for: '
  local replace = vim.fn.input 'Replace with: '
  vim.cmd('%s/' .. search .. '/' .. replace .. '/g')
end

-- Spider keymaps
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })

-- General purpose keymaps

-- Write buffer
vim.keymap.set('n', '<leader>ww', function()
  vim.cmd [[w]]
end)

-- Close buffer
vim.keymap.set('n', '<leader>wq', function()
  vim.cmd [[Sayonara]]
end)

vim.keymap.set('n', '<C-j>', '}', { desc = 'Jump To Blank Line Down' })

vim.keymap.set('n', '<C-k>', '{', { desc = 'Jump To Blank Line Up' })

-- vim: ts=2 sts=2 sw=2 et
