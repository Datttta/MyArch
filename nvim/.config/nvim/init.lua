require("core.options")
require("core.keymaps")

-- [[ `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[Padding config]]
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        os.execute("kitty @ set-spacing padding=0")
    end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        os.execute("kitty @ set-spacing padding=default")
    end,
})


require("lazy").setup({
	require("plugins.neotree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.lsp"),
	require("plugins.telescope"),
	require("plugins.cmp"),
	require("plugins.autoformat"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.blankline"),
	require("plugins.misc"),
	require("plugins.vimwiki"),
	require("plugins.imagenvim"),
	require("plugins.image-clip"),
	require("plugins.markdown-preview"),
	require("plugins.colorizer"),
	require("plugins.tokyo-night"),
	-- require("plugins.colortheme"),
	-- require("plugins.colorthemeCat"),

})
