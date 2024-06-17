return {
  'f-person/git-blame.nvim',
  config = function()
    vim.g.gitblame_virtual_text_priority = 10
    require('gitblame').setup {}
  end,
}
