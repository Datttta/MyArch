hl.config({
    decoration = {
        rounding = 4,
        rounding_power = 2,

        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 1,
            passes = 4,
            noise = 0.01,

            xray = false,
            new_optimizations = true,
            popups = false,
        },
    },
})
