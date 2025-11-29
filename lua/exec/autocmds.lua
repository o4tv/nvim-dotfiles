vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("flash") -- carregamento real do plugin
    end,
})

vim.cmd.syntax("off")
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     pattern = "*",
--     callback = function()
--         -- can start a specific treesitter on a specific buffer also
--         -- vim.treesitter.start(0, "c")
--         vim.treesitter.start()
--     end,
--     once = true,
-- })

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


