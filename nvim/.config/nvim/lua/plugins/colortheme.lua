return {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        local is_transparent = true

        local function load_nordic()
            require('nordic').setup {
                -- Add highlight overrides here
                on_highlight = function(hl, palette)
                    -- Custom line number styling
                    hl.LineNr = {
                        fg = '#88C0D0', -- Use Nordic's blue1 color (#81A1C1)
                        -- bold = true,
                        -- italic = true,
                    }

                    -- Optional: Also style CursorLineNr if needed
                    hl.CursorLineNr = {
                        fg = palette.blue2, -- Brighter blue (#88C0D0)
                        bold = true,
                    }

                    hl.Comment = {
                        fg = palette.blue1,

                    }

                    hl.Visual = {
                        bg = '#212f3d',
                    }
                end,

                transparent = { bg = is_transparent },
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
