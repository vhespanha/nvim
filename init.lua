--[[
i'll think of something cool to put here
--]]

vim.env.PATH = vim.env.PATH .. ':/home/vhespanha/.nvm/versions/node/v20.16.0/bin'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.clipboard = 'unnamed'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.gotmpl = {
  install_info = {
    url = 'https://github.com/ngalaiko/tree-sitter-go-template',
    files = { 'src/parser.c' },
  },
  filetype = 'gotmpl',
  used_by = { 'gohtmltmpl', 'gotexttmpl', 'gotmpl', 'yaml' },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
