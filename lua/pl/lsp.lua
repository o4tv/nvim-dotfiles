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
    -- jdtls = {},
    ts_ls = {},
}

for server, config in pairs(servers) do
    vim.lsp.config(server, config)
end
-- vim.lsp.config("*", { capabilities = require('blink.cmp').get_lsp_capabilities() })

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_enable = true,
})
require('mason-tool-installer').setup({
    ensure_installed = {
        'bashls',
        'clangd',
        'lua_ls',
        'stylua',
        'shellcheck',
        'editorconfig-checker',
        'shfmt',
        'pyright',
        'jdtls',
        'ts_ls',
    },
    integrations = {
        ['mason-lspconfig'] = true,
    },
})

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

require("nvim-treesitter.configs").setup({
    auto_install = true
})
