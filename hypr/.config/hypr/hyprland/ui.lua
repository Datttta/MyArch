------------------------
------ ANIMATIONS ------
------------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1.5, stiffness = 61.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10.0,  bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79,  spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.10,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 11.5,  bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2.00,  bezier = "easeOutQuint"  })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 5.00,  bezier = "easeOutQuint"  })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03,  bezier = "quick" })

hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" } )
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4.00, bezier = "easeOutQuint",  style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 8.50, bezier = "linear",        style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 5.00, bezier = "easeOutQuint" } )
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 5.00, bezier = "easeOutQuint" } )

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear",  style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 2.00, bezier = "easeOutQuint",  style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 2.00, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7.00, bezier = "quick" })

-----------------------
----- DECORATIONS -----
-----------------------

hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 4,

        border_size = 1,

        col = {
            active_border = Colors.color14,
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,

        allow_tearing = true,

        layout = "dwindle",
    },

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

--------------------
------ LAYOUT ------
--------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },
})

------------------
------ MISC ------
------------------

hl.config({
    misc = {
        disable_splash_rendering = true,
        force_default_wallpaper = 1,
        disable_hyprland_logo = false,
    },

    debug = {
        disable_logs = false,
        enable_stdout_logs = true,
    },
})

