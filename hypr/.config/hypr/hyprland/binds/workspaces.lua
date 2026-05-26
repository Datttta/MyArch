-- Switch workspaces with MainMod + [0-9]
-- Move active window to a workspace with MainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(MainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(MainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(MainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(MainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with MainMod + scroll
hl.bind(MainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(MainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
