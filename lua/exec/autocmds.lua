vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('flash') -- carregamento real do plugin
    end,
})

vim.cmd.syntax('off')
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        local wk = require('which-key')
        wk.setup({
            preset = 'helix',
        })
    end,
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    callback = function()
        require('codex').setup({
            keymaps = {
                toggle = '<M-c>',
                quit = '<C-q>',
            }
        })
    end,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
    require('go.format').goimports()
    end,
    group = format_sync_grp,
})

-- builds
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        local logfile = vim.fn.getcwd() .. "/packchanged.log"

        local function log(s)
            vim.fn.writefile({s}, logfile, "a")
        end

        if kind ~= "install" and kind ~= "update" then
            return
        end

        -- equivalente: run = 'cd lua/fzy && make'
        if name == "guihua.lua" then
            vim.system({ "make" }, { cwd = ev.data.path .. "/lua/fzy" }):wait()
        end

        -- equivalente: build = ':lua require("go.install").update_all_sync()'
        if name == "go.nvim" then
            pcall(function()
              require("go.install").update_all_sync()
            end)
        end

        log(string.format("name=%s kind=%s", tostring(name), tostring(kind)))
    end
})

-- faz o setup do luals pra editar config do neovim
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua', -- O equivalente ao ft="lua"
    callback = function()
        require('lazydev').setup({
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        })
        -- setup tem q ser depois do lazydev
        vim.lsp.enable('lua_ls')
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
