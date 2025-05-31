return {
   'vimwiki/vimwiki',
   init = function()
      vim.g.vimwiki_list = {
         {
            path = '~/vimwiki/',
            ext = '.md',
         },
      }
      vim.g.vimwiki_ext2syntax = {
         ['.md'] = 'markdown',
      }
      vim.g.vimwiki_markdown_link_ext = 1
   end,
   config = function()
      vim.api.nvim_create_autocmd('BufWritePost', {
         pattern = '*.md',
         callback = function()
            local notify = function(msg, level)
               vim.schedule(function()
                  vim.notify(msg, level)
               end)
            end

            -- Expand ~ to absolute path
            local wiki_root = vim.fn.expand(vim.g.vimwiki_list[1].path)

            -- Check if directory exists
            if vim.fn.isdirectory(wiki_root) == 0 then
               notify('Wiki directory not found: ' .. wiki_root, vim.log.levels.ERROR)
               return
            end

            -- Check if git repo
            local check_git = io.popen('git -C ' .. wiki_root .. ' rev-parse --is-inside-work-tree 2>/dev/null')
            local is_git = check_git:read '*a'
            check_git:close()

            if not is_git:match 'true' then
               notify('Not a git repository: ' .. wiki_root, vim.log.levels.WARN)
               return
            end

            local Job = require 'plenary.job'

            Job:new({
               command = 'git',
               args = { '-C', wiki_root, 'add', '.' },
               on_exit = function(_, add_code)
                  if add_code ~= 0 then
                     notify('Git add failed', vim.log.levels.ERROR)
                     return
                  end

                  Job:new({
                     command = 'git',
                     args = { '-C', wiki_root, 'commit', '-m', 'vimwiki auto-update' },
                     on_exit = function(_, commit_code)
                        if commit_code ~= 0 then
                           notify('Git commit failed (maybe no changes?)', vim.log.levels.WARN)
                           return
                        end

                        Job:new({
                           command = 'git',
                           args = { '-C', wiki_root, 'push' },
                           on_exit = function(_, push_code)
                              local msg = push_code == 0 and 'Vimwiki pushed to GitHub' or 'Git push failed'
                              notify(msg, push_code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR)
                           end,
                        }):start()
                     end,
                  }):start()
               end,
            }):start()
         end,
      })
   end,
   -- Rest of your configuration...
}
