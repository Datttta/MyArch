--------------------------
------ WINDOW RULES ------
--------------------------

-- No blur
hl.window_rule({
    match = {
        class = "kitty|.*term.*|easyeffects|pavucontrol",
    },

    no_blur = true,
})

hl.window_rule({
    match = {
        class = "^$",
        title = "^$",
    },

    no_blur = true,
})

-- no border
hl.window_rule({
    match = {
        class = "(Xdg-desktop-portal-gtk|vivaldi-stable|Opera|firefox)",
    },

    border_size = 0,
})

-- wofi
hl.window_rule({
    match = {
        class = "wofi",
    },

    rounding = 10,
})

-- Portal windows
hl.window_rule({
    match = {
        class = "[Xx]dg-desktop-portal-(gtk|hyprland)",
    },

    no_blur = true,
    float = true,
    center = true,
})

-- File dialogs
hl.window_rule({
    match = {
        title = "(Open File|Open|Save|Save As|Export|Import|Choose File)",
    },

    no_blur = true,
})

hl.window_rule({
    match = {
        title = ".*(Choose|Open File|Open|Save|Save As|Export|Import|Rename|Select).*",
    },

    float = true,
    center = true,
})

-- waypaper
hl.window_rule({
    match = {
        class = "waypaper",
    },

    float = true,
    center = true,
    size = "900 550",
})

-- copyQ
hl.window_rule({
    match = {
        class = "com.github.hluk.copyq",
    },

    float = true,
    center = true,
    size = "900 550",
})

-- browsers
hl.window_rule({
    name = "browser-maximize",

    match = {
        class = "([Vv]ivaldi-stable|Chromium|Midori|firefox|Opera)",
    },

    suppress_event = "fullscreen maximize",
})

hl.window_rule({
    match = {
        class = "(firefox|Opera|vivaldi-stable)",
    },

    float = true,
    center = true,
})

hl.window_rule({
    match = {
        class = "Opera",
    },

    size = "100% 100%",
})

-- tearing
hl.window_rule({
    match = {
        class = "org.vinegarhq.Sober",
    },

    immediate = true,
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-------------------------
------ LAYER RULES ------
-------------------------

-- blur
hl.layer_rule({
    match = {
        namespace = "waybar|swaync-control-center|logout_dialog|rofi",
    },

    blur = true,
})

hl.layer_rule({
    match = {
        namespace = "waybar|swaync-notification-window|swaync-control-center",
    },

    ignore_alpha = 0,
})

-- swaync
hl.layer_rule({
    match = {
        namespace = "swaync-control-center"
    },
    animation = "slide right",
})

-- workspaces (create a mudule for workspaces rules if necessary)
hl.workspace_rule({
    workspace = "name:1",

    gaps_in = 0,
    gaps_out = 0,
})
