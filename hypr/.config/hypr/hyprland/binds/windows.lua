hl.bind(MainMod .. " + F", hl.dsp.window.fullscreen()) -- complete fullscreen
hl.bind(MainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 })) -- almost fullscreen

hl.bind(MainMod .. " + C", hl.dsp.window.close()) -- Close active window
hl.bind(MainMod .. " + X", hl.dsp.exec_cmd("hyprctl killactive && kill -9 $(hyprctl activewindow -j | jq -r '.pid')")) -- Force kill active window

hl.bind(MainMod .. " + V", hl.dsp.window.float({ action = "toggle" })) -- Toggle floating
hl.bind(MainMod .. " + SPACE", hl.dsp.layout("togglesplit")) -- Toggle split (dwindle)
--hl.bind(MainMod .. " + P", hl.dsp.window.pseudo()) -- Toggle pseudo

-- Move focus with MainMod + vim keys
hl.bind(MainMod .. " + h",  hl.dsp.focus({ direction = "left" }))
hl.bind(MainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(MainMod .. " + k",    hl.dsp.focus({ direction = "up" }))
hl.bind(MainMod .. " + j",  hl.dsp.focus({ direction = "down" }))

-- Move/resize windows with MainMod + LMB/RMB and dragging
hl.bind(MainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
