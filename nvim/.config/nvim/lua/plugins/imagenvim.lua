-- ~/.config/nvim/lua/plugins/image.lua (or similar path depending on your setup)
return {
   {
      '3rd/image.nvim',
      opts = {
         backend = 'kitty',
         processor = 'magick_cli', -- or "magick_rock"
         integrations = {
            markdown = {
               enabled = true,
               clear_in_insert_mode = false,
               download_remote_images = true,
               only_render_image_at_cursor = false,
               only_render_image_at_cursor_mode = 'popup',
               floating_windows = false, -- if true, images will be rendered in floating markdown windows
               filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
            },
            neorg = {
               enabled = true,
               filetypes = { 'norg' },
            },
            typst = {
               enabled = true,
               filetypes = { 'typst' },
            },
            html = {
               enabled = false,
            },
            css = {
               enabled = false,
            },
         },
         max_width = nil,
         max_height = nil,
         max_width_window_percentage = nil,
         max_height_window_percentage = 50,
         window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
         window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', 'snacks_notif', 'scrollview', 'scrollview_sign' },
         editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
         tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
         hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
      },

      keys = {
         {
            '<leader>ti',
            function()
               local image = require 'image'
               -- Toggle a global variable to track state
               vim.g.images_enabled = not vim.g.images_enabled

               if vim.g.images_enabled then
                  image.setup() -- Re-registers the autocommands to show images
                  vim.cmd 'edit!' -- Refresh the buffer to render images immediately
                  print 'Images Enabled'
               else
                  image.clear() -- Removes all current images from the screen
                  -- We manually disable the integrations temporarily
                  image.setup { integrations = { markdown = { enabled = false }, vimwiki = { enabled = false } } }
                  print 'Images Disabled'
               end
            end,
            desc = 'Toggle Image Preview',
         },
      },

      dependencies = {
         'nvim-lua/plenary.nvim',
      },
   },
}
