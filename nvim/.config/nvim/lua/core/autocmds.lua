local group = vim.api.nvim_create_augroup("RestoreBufferView", {
    clear = true,
})

local saved_views = {}

vim.api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
        local win = vim.api.nvim_get_current_win()

        saved_views[win] = saved_views[win] or {}
        saved_views[win][args.buf] = vim.fn.winsaveview()
    end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    callback = function(args)
        local win = vim.api.nvim_get_current_win()
        local views = saved_views[win]
        local view = views and views[args.buf]

        if not view then
            return
        end

        vim.api.nvim_win_call(win, function()
            vim.fn.winrestview(view)
        end)
    end,
})
