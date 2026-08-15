-------------------
------ BINDS ------
-------------------

-- my programs
local terminal =    "kitty"
local fileManager = "kitty spf"
local menu =        "wofi --show drun --normal-window"

-- apps
hl.bind(MainMod .. " + Q",         hl.dsp.exec_cmd(terminal))
hl.bind(MainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(MainMod .. " + E",         hl.dsp.exec_cmd(fileManager))

-- wlogout
hl.bind(MainMod .. " + SHIFT + L", hl.dsp.exec_cmd("wlogout"))

-- SwayNC
hl.bind(MainMod .. " + N",         hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(MainMod .. " + SHIFT + N", hl.dsp.exec_cmd("killall swaync; swaync & sleep 0.5; notify-send 'Swaync restarted'"))

-- copyq
hl.bind(MainMod .. " + SHIFT + C", hl.dsp.exec_cmd("copyq toggle"))

-- Waypaper
hl.bind(MainMod .. " + W",         hl.dsp.exec_cmd("waypaper"))

-- Waybar
hl.bind(MainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall waybar; waybar"))
hl.bind(MainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("killall waybar"))

-- hyprland
hl.bind(MainMod .. " + SHIFT + M", hl.dsp.exit())

-------------------
------ MEDIA ------
-------------------

-- volume
hl.bind(MainMod .. " + EQUAL", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind(MainMod .. " + MINUS", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })

-- Brightness
hl.bind(MainMod .. " + F12",   hl.dsp.exec_cmd("brightnessctl set +10%"),                         { locked = true, repeating = true })
hl.bind(MainMod .. " + F11",   hl.dsp.exec_cmd("brightnessctl set 10%-"),                         { locked = true, repeating = true })

-- mic
hl.bind("XF86AudioMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true})
hl.bind("XF86AudioMicMute",    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true})

-- Playerctl
hl.bind("SUPER + 3",           hl.dsp.exec_cmd("playerctl next"))
hl.bind("SUPER + 2",           hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("SUPER + 1",           hl.dsp.exec_cmd("playerctl previous"))

---------------------
------ SCRIPTS ------
---------------------

-- screenshot
hl.bind("CTRL + SHIFT + S",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/screenshot.sh"))
hl.bind("CTRL + SHIFT + A",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/screenshot.sh all"))

-- upside down
hl.bind("CTRL + U + P",            hl.dsp.exec_cmd("~/.config/hypr/Scripts/upside-down.sh"))

-- turn off display
hl.bind(MainMod .. " + F6",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/turn-off-monitor.sh"))

-- gamemode
hl.bind(MainMod .. " + G",         hl.dsp.exec_cmd("~/.config/hypr/Scripts/gamemode.sh"))

-- menu
hl.bind(MainMod .. " + SHIFT + W", hl.dsp.exec_cmd(".config/hypr/Scripts/menu.sh"))

-- bluetooth
hl.bind(MainMod .. " + F1",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/connectBluetoothEarbuds.sh"))
hl.bind(MainMod .. " + F2",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/disconnectBlutooth.sh"))
hl.bind(MainMod .. " + F3",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/ShowBattery.sh"))
hl.bind(MainMod .. " + F4",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/fastBluetooth.sh"))
hl.bind(MainMod .. " + F5",        hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/highQBluetooth.sh"))

---------------------
------ WINDOWS ------
---------------------

hl.bind(MainMod .. " + F",         hl.dsp.window.fullscreen()) -- complete fullscreen
hl.bind(MainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 })) -- almost fullscreen

hl.bind(MainMod .. " + C",         hl.dsp.window.close()) -- Close active window
hl.bind(MainMod .. " + X",         hl.dsp.exec_cmd("hyprctl killactive && kill -9 $(hyprctl activewindow -j | jq -r '.pid')")) -- Force kill active window

hl.bind(MainMod .. " + V",         hl.dsp.window.float({ action = "toggle" })) -- Toggle floating
hl.bind(MainMod .. " + SPACE",     hl.dsp.layout("togglesplit")) -- Toggle split (dwindle)
--hl.bind(MainMod .. " + P",         hl.dsp.window.pseudo()) -- Toggle pseudo

-- Move focus with MainMod + vim keys
hl.bind(MainMod .. " + h",         hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + l",         hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + k",         hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + j",         hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with MainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------------
------ WORKSPACES ------
------------------------

-- Switch workspaces with MainMod + [0-9]
-- Move active window to a workspace with MainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(MainMod .. " + S",                       hl.dsp.workspace.toggle_special("minimize"))
hl.bind(MainMod .. " + SHIFT + S",               hl.dsp.window.move({ workspace = "special:minimize" }))

-- Scroll through existing workspaces with MainMod + scroll
hl.bind(MainMod .. " + mouse_down",              hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MainMod .. " + mouse_up",                hl.dsp.focus({ workspace = "e-1" }))

