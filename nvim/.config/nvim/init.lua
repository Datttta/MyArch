require("core.options")
require("core.keymaps")
require("core.plugin-manager")
require("core.padding-config")

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
	require("plugins.colorizer"),
	require("plugins.tokyo-night"),
	require("plugins.nvim-orgmode"),
	-- require("plugins.colortheme"),
	-- require("plugins.colorthemeCat"),

})
