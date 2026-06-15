-----------------------
------ AUTOSTART ------
-----------------------

local apps = {
    "systemctl --user start hyprpolkitagent",
    "syncthing --no-browser",
    "sleep 1 && waybar",
    "hyprpaper",
    "swaync",
}

hl.on("hyprland.start", function()

    for _, cmd in ipairs(apps) do
        hl.exec_cmd(cmd)
    end

    os.execute("mkdir " .. Log_path)

    hl.exec_cmd([[
        sh -c '
        ~/.config/hypr/Scripts/random-wallpaper.sh > ]] .. Log_path .. [[/random-wallpaper.log 2>&1 && \
        ~/.config/hypr/Scripts/vimwiki.sh > ]] .. Log_path .. [[/vimwiki_sh.log 2>&1 && \
        ~/.config/hypr/Scripts/launcher.sh start-copyq > ]] .. Log_path .. [[/launcher.log 2>&1
        '
    ]])
end)

-----------------
------ ENV ------
-----------------

hl.env("XCURSOR_SIZE", "24")

hl.env("EDITOR", "nvim")
hl.env("SHELL", "/usr/bin/zsh")

hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("VDPAU_DRIVER", "va_gl")

hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("WLR_DRM_NO_ATOMIC", "1")

hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")

------------------------
------ PERMISSION ------
------------------------

hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")

hl.permission( "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")

hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-------------------
------ INPUT ------
-------------------

hl.config({
    input = {
        kb_layout = "br",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "flat",
    },

    cursor = {
        no_hardware_cursors = true,
    },
})

hl.device = {
    name = "epic-mouse-v1",
    sensitivity = -0.5,
}

----------------------
------ MONITORS ------
----------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})
