-- configuraçao de cada ls
-- vazio = padrao
local servers = {
    lua_ls = {
        settings = {
            Lua = {
                --         workspace = {
                --             checkThirdParty = false,
                --             -- library = vim.api.nvim_get_runtime_file("", true),
                --             -- library = {
                --             --     vim.env.VIMRUNTIME,
                --             -- },
                --             maxPreload = 2000,
                --             preloadFileSize = 1000,
                --         },
                telemetry = { enable = false },
            },
        },
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

-- setup do mason + ativaçao automatica de cada ls
require('mason').setup()
require('mason-lspconfig').setup({
    automatic_enable = true,
})
require('mason-tool-installer').setup({
    ensure_installed = {
        'bashls',
        'clangd',
        ---- desativado por uma excessao na versao de uma lib
        ---- ativado posteriormente no lazydev
        -- 'lua_ls',
        'stylua',
        'shellcheck',
        'editorconfig-checker',
        'shfmt',
        'pyright',
        'jdtls',
        'ts_ls',
        'sqlls',
        'prettier',
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
        source = 'if_many',
        prefix = '●',
    },
    severity_sort = true,
    signs = true,
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    auto_install = true,
})

require('fidget').setup({})
