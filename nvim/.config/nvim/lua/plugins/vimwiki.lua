return {
  {
    'vimwiki/vimwiki',
    -- set globals before the plugin loads:
    keys = { '<leader>ç', '<leader>wt' },
    init = function()
      -- 1) define your wiki, with syntax='markdown'
      vim.g.vimwiki_list = {
        {
          path = '~/vimwiki/',
          ext = '.md',
        },
      }
      -- 2) tell Vimwiki that ".md" files use markdown syntax
      vim.g.vimwiki_ext2syntax = {
        ['.md'] = 'markdown',
      }
      -- optional: allow links with .md extension
      vim.g.vimwiki_markdown_link_ext = 1
    end,
    -- load only when you actually need Vimwiki:
    cmd = { 'VimwikiIndex', 'VimwikiUISelect', 'VimwikiDiaryIndex' },
    ft = { 'vimwiki', 'markdown' },

    keys = {
      -- open the wiki index
      { '<leader>ww', '<cmd>VimwikiIndex<cr>',         desc = 'Vimwiki: Index' },
      -- open the diary index
      { '<leader>wd', '<cmd>VimwikiDiaryIndex<cr>',    desc = 'Vimwiki: Diary' },
      -- create/edit today's diary
      { '<leader>wt', '<cmd>VimwikiMakeDiaryNote<cr>', desc = 'Vimwiki: Today' },
    },
  },
}
