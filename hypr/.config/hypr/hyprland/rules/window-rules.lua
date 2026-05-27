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
        class = "(Xdg-desktop-portal-gtk|vivaldi-stable|Vivaldi-stable|Opera|firefox)",
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
        class = "(firefox|Opera|vivaldi-stable|Vivaldi-stable)",
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
