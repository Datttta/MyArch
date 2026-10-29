Colors = dofile(os.getenv("HOME") .. "/.cache/wal/rgba-colors.lua")
Log_path = "/tmp/mylogs"

local path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"
hl.env("PATH", os.getenv("HOME") .. "/.local/bin:" .. path)

MainMod = "ALT"

require("hyprland.core")
require("hyprland.binds")
require("hyprland.ui")
require("hyprland.rules")

