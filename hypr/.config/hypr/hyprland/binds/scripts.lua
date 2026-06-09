-- screenshot
hl.bind("CTRL + SHIFT + S", hl.dsp.exec_cmd("~/Repos/MyArch/storage/scripts/screenshot.sh"))
hl.bind("CTRL + SHIFT + A", hl.dsp.exec_cmd("grimblast --freeze --notify save screen"))

-- upside down
hl.bind("CTRL + U + P", hl.dsp.exec_cmd("~/.config/hypr/Scripts/upside-down.sh"))

-- gamemode
hl.bind(MainMod .. " + G", hl.dsp.exec_cmd("~/.config/hypr/Scripts/gamemode.sh"))

-- menu
hl.bind(MainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/Repos/MyArch/storage/scripts/menu.sh"))

-- bluetooth
hl.bind(MainMod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/connectBluetoothEarbuds.sh"))
hl.bind(MainMod .. " + F2", hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/disconnectBlutooth.sh"))
hl.bind(MainMod .. " + F3", hl.dsp.exec_cmd("kitty ~/.config/hypr/Scripts/bluetooth/ShowBattery.sh"))
hl.bind(MainMod .. " + F4", hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/fastBluetooth.sh"))
hl.bind(MainMod .. " + F5", hl.dsp.exec_cmd("~/.config/hypr/Scripts/bluetooth/highQBluetooth.sh"))

