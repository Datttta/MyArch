return {
   'vimwiki/vimwiki',

   init = function()
      vim.g.vimwiki_list = {
         {
            path = '~/Repos/vimwiki/',
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
      -- Git auto-commit on <leader>p
      ----------------------------------------------------------------------
      local function push_vimwiki()
         local wiki_root = vim.fn.expand(vim.g.vimwiki_list[1].path)
         local Job = require 'plenary.job'

         Job:new({
            command = 'git',
            args = { '-C', wiki_root, 'add', '.' },
            on_exit = function()
               Job:new({
                  command = 'git',
                  args = { '-C', wiki_root, 'commit', '-m', 'update' },
                  on_exit = function()
                     Job:new({
                        command = 'git',
                        args = { '-C', wiki_root, 'push' },
                        on_exit = function(_, code)
                           vim.schedule(function()
                              if code == 0 then
                                 vim.notify('Vimwiki pushed to Git', vim.log.levels.INFO)
                              else
                                 vim.notify('Git push failed', vim.log.levels.ERROR)
                              end
                           end)
                        end,
                     }):start()
                  end,
               }):start()
            end,
         }):start()
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
            vim.keymap.set("n", "<leader>p", push_vimwiki, {
               buffer = true,
               desc = "Push vimwiki to git",
             })
         end,
      })

   end,
}
