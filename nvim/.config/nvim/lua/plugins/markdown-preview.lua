return {
   {
      'iamcco/markdown-preview.nvim',
      build = 'cd app && npm install',
      ft = 'markdown',                    -- Only load for markdown files
      config = function()
         vim.g.mkdp_auto_start = 0        -- Disable auto-start
         vim.g.mkdp_auto_close = 1        -- Close preview window when switching buffers
         vim.g.mkdp_refresh_slow = 0      -- Refresh instantly
         vim.g.mkdp_port = '8888'         -- Custom port if needed
         vim.g.mkdp_open_to_the_world = 0 -- Restrict to localhost
         vim.g.mkdp_open_ip = '127.0.0.1' -- Localhost only
      end,
      keys = {
         { '<leader>pr', '<cmd>MarkdownPreview<CR>',     desc = 'Markdown Preview' },
         { '<leader>pt', '<cmd>MarkdownPreviewStop<CR>', desc = 'Stop Markdown Preview' },
      },
   },
}
