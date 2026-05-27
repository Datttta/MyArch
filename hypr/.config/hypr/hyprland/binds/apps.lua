-- my programs
local terminal =    "kitty"
local fileManager = "kitty yazi"
local menu =        "wofi --show drun --normal-window"

-- apps
hl.bind(MainMod .. " + Q",         hl.dsp.exec_cmd(terminal))
hl.bind(MainMod .. " + R",         hl.dsp.exec_cmd(menu))
hl.bind(MainMod .. " + E",         hl.dsp.exec_cmd(fileManager))

-- wlogout
hl.bind(MainMod .. " + SHIFT + L", hl.dsp.exec_cmd("wlogout"))

-- SwayNC
hl.bind(MainMod .. " + N",         hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(MainMod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.config/swaync/scripts/swayncRestart.sh"))

-- Clipboard
hl.bind(MainMod .. " + SHIFT + C", hl.dsp.exec_cmd("copyq toggle"))

-- Wallpaper
hl.bind(MainMod .. " + W",         hl.dsp.exec_cmd("waypaper"))

-- Waybar
hl.bind(MainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall waybar && waybar"))
hl.bind(MainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("killall waybar"))

-- hyprland
hl.bind(MainMod .. " + SHIFT + M", hl.dsp.exit())
