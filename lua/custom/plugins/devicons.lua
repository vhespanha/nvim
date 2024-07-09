return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup {
      color_icons = true,
      override_by_extension = {
        ['go'] = {
          icon = '',
          color = '#58a6ff',
          name = 'Go',
        },
        ['mod'] = {
          icon = '',
          color = '#ff7b72',
          name = 'Go',
        },
        ['js'] = {
          icon = '',
          color = '#e3b341',
          name = 'Js',
        },
        ['cjs'] = {
          icon = '',
          color = '#3fb950',
          name = 'Cjs',
        },
        ['mjs'] = {
          icon = '',
          color = '#be8fff',
          name = 'Mjs',
        },
        ['ts'] = {
          icon = '',
          color = '#58a6ff',
          name = 'Ts',
        },
        ['spec.js'] = {
          icon = '',
          color = '#e3b341',
          name = 'SpecJs',
        },
        ['spec.jsx'] = {
          icon = '',
          color = '#e3b341',
          name = 'JavaScriptReactSpec',
        },
        ['spec.ts'] = {
          icon = '',
          color = '#58a6ff',
          name = 'SpecTs',
        },
        ['spec.tsx'] = {
          icon = '',
          color = '#58a6ff',
          name = 'TypeScriptReactSpec',
        },
        ['svelte'] = {
          icon = '',
          color = '#f0883e',
          name = 'Svelte',
        },
        ['prisma'] = {
          icon = '',
          color = '#7d8590',
          name = 'Prisma',
        },
        ['vue'] = {
          icon = '',
          color = '#3fb950',
          name = 'Vue',
        },
        ['jsx'] = {
          icon = '',
          color = '#e3b341',
          name = 'Jsx',
        },
        ['tsx'] = {
          icon = '',
          color = '#58a6ff',
          name = 'Tsx',
        },
        ['sql'] = {
          icon = '',
          color = '#7d8590',
          name = 'SQL',
        },
        ['sqlite'] = {
          icon = '',
          color = '#58a6ff',
          name = 'SQLite',
        },
        ['sqlite3'] = {
          icon = '',
          color = '#3fb950',
          name = 'SQLite3',
        },
        ['html'] = {
          icon = '',
          color = '#f0883e',
          name = 'Html',
        },
        ['templ'] = {
          icon = '',
          color = '#e3b341',
          name = 'Templ',
        },
        ['png'] = {
          icon = '',
          color = '#be8fff',
          name = 'Png',
        },
      },
    }
  end,
}, {
  'rachartier/tiny-devicons-auto-colors.nvim',
  config = function()
    require('tiny-devicons-auto-colors').setup {
      colors = {
        '#7d8590',
        '#58a6ff',
        '#3fb950',
        '#e3b341',
        '#f0883e',
        '#ff7b72',
        '#be8fff',
        '#f778ba',
        '#f78166',
      },
    }
  end,
}
