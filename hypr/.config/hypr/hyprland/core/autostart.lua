local apps = {
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "syncthing --no-browser",
    "~/.config/hypr/Scripts/launcher.sh start-copyq",
    "sleep 1 && waybar",
    "hyprpaper",
    "swaync",
}

hl.on("hyprland.start", function()

    for _, cmd in ipairs(apps) do
        hl.exec_cmd(cmd)
    end

    hl.exec_cmd([[
        sh -c '~/.config/hypr/Scripts/random-wallpaper.sh \
        > /tmp/wallpaper.log 2>&1 && \
        ~/Repos/MyArch/storage/scripts/vimwiki.sh \
        > /tmp/vimwiki_sh.log 2>&1'
    ]])

end)
