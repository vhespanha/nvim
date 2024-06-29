return {
  'vhespanha/wtf.nvim',
  branch = 'develop',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    popup_type = 'popup',
    openai_api_key_cmd = 'pass show api/openai/nvim',
    openai_model_id = 'gpt-3.5-turbo-16k',
    context = true,
    language = 'english',
    search_engine = 'phind',
    winhighlight = 'Normal:Normal,FloatBorder:CmpBorder',
    hooks = {
      request_started = function()
        vim.g.wtf_request_running = true
      end,
      request_finished = function()
        vim.g.wtf_request_running = false
      end,
    },
  },
  keys = {
    {
      'gw',
      mode = { 'n', 'x' },
      function()
        require('wtf').ai()
      end,
      desc = 'Debug diagnostic with AI',
    },
    {
      mode = { 'n' },
      'gW',
      function()
        require('wtf').search()
      end,
      desc = 'Search diagnostic with Google',
    },
  },
}
