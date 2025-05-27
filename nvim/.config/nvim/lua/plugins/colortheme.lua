return {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local is_transparent = true

        local function load_nordic()
            require('nordic').setup {
                transparent = { bg = is_transparent }, -- 🔄 toggle here

                bold_keywords = false,
                italic_comments = true,
                reduced_blue = true,
                swap_backgrounds = false,
                bright_border = false,

                cursorline = {
                    bold = false,
                    bold_number = true,
                    theme = 'dark',
                    blend = 0.85,
                },

                noice = { style = 'classic' },
                telescope = { style = 'flat' },
                leap = { dim_backdrop = false },
                ts_context = { dark_background = true },

                on_palette = function(palette) end,
                after_palette = function(palette) end,
                on_highlight = function(highlights, palette) end,
            }

            require('nordic').load()
        end

        -- Load theme initially
        load_nordic()

        -- Toggle transparency
        vim.keymap.set('n', '<leader>bg', function()
            is_transparent = not is_transparent
            load_nordic()
            print('Background transparency: ' .. (is_transparent and 'on' or 'off'))
        end, { noremap = true, silent = true, desc = 'Toggle background transparency' })
    end,
}
