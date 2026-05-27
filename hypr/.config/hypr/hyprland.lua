Colors = dofile(os.getenv("HOME") .. "/.cache/wal/rgba-colors.lua")
MainMod = "ALT"

require("hyprland.core.monitors")
require("hyprland.core.autostart")
require("hyprland.core.env")
require("hyprland.core.input")

require("hyprland.binds.apps")
require("hyprland.binds.media")
require("hyprland.binds.scripts")
require("hyprland.binds.workspaces")
require("hyprland.binds.windows")

require("hyprland.ui.general")
require("hyprland.ui.decoration")
require("hyprland.ui.layout")
require("hyprland.ui.animations")
require("hyprland.ui.misc")

require("hyprland.rules.permissions")
require("hyprland.rules.window-rules")
require("hyprland.rules.layer-rules")

