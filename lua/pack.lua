local packages = {}
for line in io.lines("/home/tavin/.config/nvim/packages.txt") do
    table.insert(packages, { src = "https://github.com/" .. line })
end
-- print(vim.inspect(packages))
vim.pack.add(packages)












-- local packages = {
--     'neovim/nvim-lspconfig',
--     'mason-org/mason.nvim',
--     'mason-org/mason-lspconfig.nvim',
--     'WhoIsSethDaniel/mason-tool-installer.nvim',
--     'saghen/blink.cmp',
-- }
-- for i, pkg in ipairs(packages) do
--     packages[i] = { src = "https://github.com/" .. pkg }
-- end


