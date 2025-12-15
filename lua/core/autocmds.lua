vim.cmd.syntax('off')
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

---- QOL
-- highlight no texto yankado
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlights text when yanking',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- retorna o cursor de onde parou
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function()
                vim.cmd('normal! zz')
            end)
        end
    end,
})

-- auto redimensionamento quando o tamanho do terminal muda
vim.api.nvim_create_autocmd('VimResized', {
    command = 'wincmd =',
})

-- disable auto comments
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = 'wincmd L',
})
