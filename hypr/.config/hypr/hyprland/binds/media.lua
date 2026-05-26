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
