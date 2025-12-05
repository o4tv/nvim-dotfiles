vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("flash") -- carregamento real do plugin
    end,
})

vim.cmd.syntax("off")
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local wk = require("which-key")
        wk.setup({
            preset = "modern",
        })
        wk.add({
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
            {
                "<leader>!",
                function()
                    require("which-key").show({ global = true })
                end,
                desc = "Buffer Global Keymaps (which-key)",
            },

        })
    end,
})

-- abre o dashboard quando o utlimo buffer é fechado
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function()
        vim.schedule(function()
            local buffers = vim.api.nvim_list_bufs()
            local listed_buffers = {}

            -- lista so os arquivos abertos
            for _, buf in ipairs(buffers) do
                if vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
                    -- ignora se o buffer é o dashboard
                    if vim.api.nvim_get_option_value("filetype", { buf = buf }) ~= "dashboard" then
                        table.insert(listed_buffers, buf)
                    end
                end
            end

            if #listed_buffers > 1 or (listed_buffers[1] and vim.api.nvim_buf_get_name(listed_buffers[1]) ~= "") then
                return
            end
            vim.cmd("Dashboard")

        end)
    end,
})

-- retorna o cursor de onde parou
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function (args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            vim.schedule(function ()
                vim.cmd("normal! zz")
            end)
        end
    end
})

-- auto redimensionamento quando o tamanho do terminal muda
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd ="
})

-- disable auto comments
vim.api.nvim_create_autocmd("FileType", {
    callback = function ()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

