vim.schedule(function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
end)

