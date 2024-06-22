return {
  'chrisgrieser/nvim-tinygit',
  config = function()
    require('tinygit').setup {
      commitMsg = {
        commitPreview = true, -- requires nvim-notify
        spellcheck = true,
        keepAbortedMsgSecs = 300,
        inputFieldWidth = false, -- `false` to use dressing.nvim config
        conventionalCommits = {
          enforce = true,
          keywords = {
            'fix',
            'feat',
            'chore',
            'docs',
            'refactor',
            'build',
            'test',
            'perf',
            'style',
            'revert',
            'ci',
            'break',
            'improv',
          },
        },
        openReferencedIssue = true, -- if message has issue/PR, open in browser afterwards
        insertIssuesOnHash = {
          -- Experimental. Typing `#` will insert the most recent open issue.
          -- Requires nvim-notify.
          enabled = false,
          next = '<Tab>', -- insert & normal mode
          prev = '<S-Tab>',
          issuesToFetch = 20,
        },
      },
      backdrop = {
        enabled = true,
        blend = 60, -- 0-100
      },
      push = {
        preventPushingFixupOrSquashCommits = true,
      },
      historySearch = {
        diffPopup = {
          width = 0.8, -- float, 0 to 1
          height = 0.8,
          border = 'single',
        },
        autoUnshallowIfNeeded = false,
      },
      statusline = {
        branchState = {
          icons = {
            ahead = ' ',
            behind = ' ',
            diverge = ' ',
          },
        },
      },
    }
  end,
}
