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

-- workspaces (create a mudule for workspaces rules if necessary)
hl.workspace_rule({
    workspace = "name:1",

    gaps_in = 0,
    gaps_out = 0,
})
