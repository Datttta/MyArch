return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,

    config = function()
      -- ensure parser install system is initialized
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- install parsers
      require("nvim-treesitter").install({
        "sql",
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "gitignore",
        "go",
        "html",
        "lua",
        "markdown",
        "python",
        "vim",
      })

      -- enable treesitter highlighting on file open
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "sql",
          "lua",
          "python",
          "go",
          "cpp",
          "c",
          "html",
          "css",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
