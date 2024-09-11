local ft = vim.api.nvim_create_augroup('filetype_gohtml', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = ft,
  pattern = '*.gohtml',
  callback = function()
    vim.bo.filetype = 'html'
  end,
})
