-- configuraçao de cada ls
-- vazio = padrao
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                }
            },
        }
    },
    pyright = {},
    clangd = {},
    jdtls = {},
    ts_ls = {},
    sqlls = {},
}

-- aplicaçao da configuraçao de cada um
for server, config in pairs(servers) do
    if config ~= {} then
        vim.lsp.config(server, config)
    end
end
-- excessao pq ta dando um erro na versao dada pelo mason
vim.lsp.enable('lua_ls')

-- setup do mason + ativaçao automatica de cada ls
require("mason").setup()
require("mason-lspconfig").setup({
    automatic_enable = true,
})
require('mason-tool-installer').setup({
    ensure_installed = {
        'bashls',
        'clangd',
        ---- desativado pq a versao da bugada
        -- 'lua_ls',
        'stylua',
        'shellcheck',
        'editorconfig-checker',
        'shfmt',
        'pyright',
        'jdtls',
        'ts_ls',
        'sqlls',
    },
    integrations = {
        ['mason-lspconfig'] = true,
    },
})

-- para os erros aparecerem em linha
vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
    signs = true,
})

-- nao sei pq dá esse warning
require("nvim-treesitter.configs").setup({
    auto_install = true
})
