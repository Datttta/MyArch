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

      vim.g.vimwiki_key_mappings = {
         all = {
            next_link = '',
            prev_link = '',
         },
      }
   end,

   config = function()
      ----------------------------------------------------------------------
      -- Toggle task + jump to next empty line
      ----------------------------------------------------------------------
      local function toggle_task_and_move_if_done()
         local buf = 0
         local cursor = vim.api.nvim_win_get_cursor(0)
         local row = cursor[1]

         local before = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]

         vim.cmd 'VimwikiToggleListItem'

         local after = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1]

         -- Only act when task was just Completed
         if before and after and not before:match '%[X%]' and after:match '%[X%]' then
            -- Remove original line
            vim.api.nvim_buf_set_lines(buf, row - 1, row, false, {})

            local line_count = vim.api.nvim_buf_line_count(buf)
            local Completed_header_line = nil

            -- 1. Find "== Completed ==" header
            for i = 1, line_count do
               local line = vim.api.nvim_buf_get_lines(buf, i - 1, i, false)[1]
               if line == '== Completed ==' then
                  Completed_header_line = i
                  break
               end
            end

            -- 2. If header not found, append it at end
            if not Completed_header_line then
               vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, {
                  '',
                  '== Completed ==',
                  '',
               })
               Completed_header_line = line_count + 2
               line_count = vim.api.nvim_buf_line_count(buf)
            end

            -- 3. Find first empty line AFTER "== Completed =="
            for i = Completed_header_line + 1, line_count do
               local line = vim.api.nvim_buf_get_lines(buf, i - 1, i, false)[1]
               if line == '' then
                  vim.api.nvim_buf_set_lines(buf, i - 1, i - 1, false, { after })
                  vim.api.nvim_win_set_cursor(0, cursor)
                  return
               end
            end

            -- 4. No empty line found → append at end
            vim.api.nvim_buf_set_lines(buf, line_count, line_count, false, { '', after })
            vim.api.nvim_win_set_cursor(0, cursor)
         end
      end
      ----------------------------------------------------------------------
      -- FileType autocmd
      ----------------------------------------------------------------------
      vim.api.nvim_create_autocmd('FileType', {
         pattern = 'vimwiki',
         callback = function()
            vim.keymap.del('n', '<Tab>', { buffer = true })
            vim.keymap.del('n', '<S-Tab>', { buffer = true })
            vim.keymap.del('n', '<C-Space>', { buffer = true })

            vim.keymap.set('n', '<C-Space>', toggle_task_and_move_if_done, {
               buffer = true,
               desc = 'Vimwiki: complete task and jump to next empty line',
            })
         end,
      })

      ----------------------------------------------------------------------
      -- Git auto-commit on save
      ----------------------------------------------------------------------
      vim.api.nvim_create_autocmd('BufWritePost', {
         pattern = '*.md',
         callback = function()
            local notify = function(msg, level)
               vim.schedule(function()
                  vim.notify(msg, level)
               end)
            end

            local wiki_root = vim.fn.expand(vim.g.vimwiki_list[1].path)

            if vim.fn.isdirectory(wiki_root) == 0 then
               notify('Wiki directory not found: ' .. wiki_root, vim.log.levels.ERROR)
               return
            end

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
                              notify(
                                 push_code == 0 and 'Vimwiki pushed to GitHub' or 'Git push failed',
                                 push_code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
                              )
                           end,
                        }):start()
                     end,
                  }):start()
               end,
            }):start()
         end,
      })
   end,
}
