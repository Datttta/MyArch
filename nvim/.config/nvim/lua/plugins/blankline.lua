return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = function()
    -- Get Nordic color palette
    local palette = require('nordic.colors.nordic')

    return {
      indent = {
        char = '▏',
        highlight = 'IblIndentInactive', -- Custom highlight group
      },
      scope = {
        show_start = false,
        show_end = false,
        highlight = 'IblScopeActive', -- Custom scope highlight
        show_exact_scope = false,
      },
      exclude = {
        filetypes = {
          'help', 'startify', 'dashboard', 'packer',
          'neogitstatus', 'NvimTree', 'Trouble',
        },
      },
    }
  end,
  config = function(_, opts)
    -- Define highlight groups using Nordic colors
    vim.api.nvim_set_hl(0, 'IblIndentInactive', {
      fg = '#5c818e', -- #4C566A
      nocombine = true,
    })

    vim.api.nvim_set_hl(0, 'IblScopeActive', {
      fg = require('nordic.colors.nordic').blue2, -- #88C0D0
      nocombine = true,
    })

    require('ibl').setup(opts)
  end
}
