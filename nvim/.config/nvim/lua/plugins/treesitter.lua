return {
  {
    'nvim-treesitter/nvim-treesitter',

    -- Runs BEFORE the plugin is loaded
    init = function()
      require('nvim-treesitter.install').prefer_git = true
    end,

    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',

    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'diff',
        'gitignore',
        'go',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'toml',
        'vim',
        'vimdoc',
        'python',
      },

      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
  },
}
