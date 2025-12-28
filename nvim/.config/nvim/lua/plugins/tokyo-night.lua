return {
   'folke/tokyonight.nvim',
   lazy = false,
   priority = 1000,
   config = function()
      local is_transparent = true

      local function load_tokyonight()
         require('tokyonight').setup {
            style = 'night', -- moon, night, storm, day
            transparent = is_transparent,
         }
         vim.cmd 'colorscheme tokyonight'
         if is_transparent then
            vim.cmd 'highlight NeoTreeNormal guibg=NONE ctermbg=NONE'
            vim.cmd 'highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE'
         end
      end

      load_tokyonight()

      vim.keymap.set('n', '<leader>bg', function()
         is_transparent = not is_transparent
         load_tokyonight()
         print('Background transparency: ' .. (is_transparent and 'on' or 'off'))
      end, { noremap = true, silent = true, desc = 'Toggle background transparency' })
   end,
}
