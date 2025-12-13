require("recycle-bin"):setup()

local pref_by_location = require("pref-by-location")
pref_by_location:setup({
  -- Disable this plugin completely.
  -- disabled = false -- true|false (Optional)

  -- Hide "enable" and "disable" notifications.
  -- no_notify = false -- true|false (Optional)

  -- Disable the fallback/default preference (values in `yazi.toml`).
  -- This mean if none of the saved or predifined perferences is matched,
  -- then it won't reset preference to default values in yazi.toml.
  -- For example, go from folder A to folder B (folder B matchs saved preference to show hidden files) -> show hidden.
  -- Then move back to folder A -> keep showing hidden files, because the folder A doesn't match any saved or predefined preference.
  -- disable_fallback_preference = false -- true|false|nil (Optional)

  -- You can backup/restore this file. But don't use same file in the different OS.
  -- save_path =  -- full path to save file (Optional)
  --       - Linux/MacOS: os.getenv("HOME") .. "/.config/yazi/pref-by-location"
  --       - Windows: os.getenv("APPDATA") .. "\\yazi\\config\\pref-by-location"

  -- This is predefined preferences.
})
