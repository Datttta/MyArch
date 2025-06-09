return {
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                '*',                                -- Highlight all filetypes
                css = { rgb_fn = true, hsl_fn = true }, -- Extra CSS features
            }, {
                RGB = true,                         -- Enable #RGB hex codes
                RRGGBB = true,                      -- Enable #RRGGBB hex codes
                RRGGBBAA = true,                    -- Enable 8-digit hex codes with alpha
                names = false,                      -- Don't show color names
                rgb_fn = true,                      -- Enable rgb() colors
                hsl_fn = true,                      -- Enable hsl() colors
                css = true,                         -- Enable CSS parsing
                css_fn = true,                      -- Enable CSS functions
                mode = 'background',                -- Show color as background
            })
        end,
    },
}
