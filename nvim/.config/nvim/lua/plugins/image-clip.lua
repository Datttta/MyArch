return {
   {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
         default = {
            -- file and directory options
            dir_path = function()
               return vim.fn.expand '%:p:h' .. '/screenshots' -- Save in 'screenshots' relative to the current file
            end,
            extension = 'png',
            file_name = '%Y-%m-%d-%H-%M-%S',
            use_absolute_path = false,
            relative_to_current_file = false,

            -- template options
            template = '$FILE_PATH',
            url_encode_path = false,
            relative_template_path = true,
            use_cursor_in_template = true,
            insert_mode_after_paste = false,

            -- prompt options
            prompt_for_file_name = true,
            show_dir_path_in_prompt = false,

            -- base64 options
            max_base64_size = 10,
            embed_image_as_base64 = false,

            -- image options
            process_cmd = '',
            copy_images = false,
            download_images = true,

            -- drag and drop options
            drag_and_drop = {
               enabled = true,
               insert_mode = false,
            },
         },

         -- filetype specific options
         filetypes = {
            markdown = {
               url_encode_path = false,                 -- previously true
               template = '![Image](screenshots/%s)\n', -- Use relative path for conceal compatibility
               download_images = false,
            },

            vimwiki = {
               url_encode_path = false, -- previously true
               template = '![$CURSOR]($FILE_PATH)\n',
               relative_template_path = true,
               download_images = false,
            },

            html = {
               template = '<img src="$FILE_PATH" alt="$CURSOR">',
            },

            tex = {
               relative_template_path = false,
               template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
                    ]],
            },

            typst = {
               template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
                    ]],
            },

            rst = {
               template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
                    ]],
            },

            asciidoc = {
               template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]',
            },

            org = {
               template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
                    ]=],
            },
         },

         -- file, directory, and custom triggered options
         files = {},
         dirs = {},
         custom = {},
      },
      keys = {
         { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
      },
   },
}
