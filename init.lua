require 'pack'
require 'pl.theme'
require 'pl.ya'
require 'options'

vim.schedule(function()
    vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
end)

print("on")
