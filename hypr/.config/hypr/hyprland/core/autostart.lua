local apps = {
    "syncthing --no-browser",
    "copyq --start-server",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "hyprpaper",
    "swaync",
    "waybar"
}

hl.on("hyprland.start", function()

    for _, cmd in ipairs(apps) do
        hl.exec_cmd(cmd)
    end

    hl.exec_cmd([[
        sh -c '~/.config/hypr/Scripts/random-wallpaper.sh \
        > ~/.local/state/wallpaper_log.txt 2>&1 && \
        ~/Repos/MyArch/storage/scripts/vimwiki.sh \
        > ~/.local/state/vimwiki_sh.log 2>&1'
    ]])

end)
