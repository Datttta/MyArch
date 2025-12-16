return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    local is_transparent = true

    local function load_catpuccin()
      require('catppuccin').setup {
        flavour = 'auto',
        background = {
          light = 'latte',
          dark = 'mocha',
        },

        transparent_background = is_transparent,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = 'dark',
          percentage = 0.15,
        },

        no_italic = false,
        no_bold = false,
        no_underline = false,

        styles = {
          comments = { 'italic' },
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },

        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin'
      if is_transparent then
        vim.cmd 'highlight NeoTreeNormal guibg=NONE ctermbg=NONE'
        vim.cmd 'highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE'
      end
    end

    load_catpuccin()

    vim.keymap.set('n', '<leader>bg', function()
      is_transparent = not is_transparent
      load_catpuccin()
      print('Background transparency: ' .. (is_transparent and 'on' or 'off'))
    end, { noremap = true, silent = true, desc = 'Toggle background transparency' })
  end,
}
