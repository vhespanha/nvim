local openai_api_key = vim.env.OPENAI_API_KEY

return {
  'piersolenski/wtf.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- Default AI popup type
    popup_type = 'popup',
    -- An alternative way to set your API key
    openai_api_key = openai_api_key,
    -- ChatGPT Model
    openai_model_id = 'gpt-4o',
    -- Send code as well as diagnostics
    context = true,
    -- Set your preferred language for the response
    language = 'english',
    -- Default search engine, can be overridden by passing an option to WtfSeatch
    search_engine = 'phind',
    -- Callbacks
    hooks = {
      request_started = nil,
      request_finished = nil,
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
