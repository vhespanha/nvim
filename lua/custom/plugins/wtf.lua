return {
  'vhespanha/wtf.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    -- Default AI popup type
    popup_type = 'popup',
    -- An alternative way to set your API key
    openai_api_key_cmd = 'pass show api/openai/nvim',
    -- ChatGPT Model
    openai_model_id = 'gpt-4-turbo',
    -- Send code as well as diagnostics
    context = true,
    -- Set your preferred language for the response
    language = 'english',
    -- Any additional instructions
    search_engine = 'phind',
    -- Add custom colours
    winhighlight = 'Normal:Normal,FloatBorder:CmpBorder',
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
