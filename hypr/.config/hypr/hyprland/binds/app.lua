local programs = require("hyprland.core.programs")

hl.bind(MainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(MainMod .. " + R", hl.dsp.exec_cmd(programs.menu))
hl.bind(MainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))

-- wlogout
hl.bind(MainMod .. " + SHIFT + L", hl.dsp.exec_cmd("wlogout"))

-- SwayNC
hl.bind(MainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(MainMod .. " + SHIFT + N", hl.dsp.exec_cmd("~/.config/swaync/scripts/swayncRestart.sh"))

-- Clipboard
hl.bind(MainMod .. " + SHIFT + C", hl.dsp.exec_cmd("copyq toggle"))

-- Wallpaper
hl.bind(MainMod .. " + W", hl.dsp.exec_cmd("waypaper"))

-- Waybar
hl.bind(MainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall waybar && waybar"))
hl.bind(MainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("killall waybar"))

