Colors = dofile(os.getenv("HOME") .. "/.cache/wal/colors.lua")
MainMod = "ALT"

require("hyprland.core.monitors")
require("hyprland.core.autostart")
require("hyprland.core.programs")
require("hyprland.core.env")
require("hyprland.core.input")

require("hyprland.ui.general")
require("hyprland.ui.decoration")
require("hyprland.ui.layout")
require("hyprland.ui.animations")
require("hyprland.ui.misc")

require("hyprland.rules.permissions")
