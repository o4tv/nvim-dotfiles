return {
    {
        -- Plugin principal de LSP
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Gerenciadores de pacotes LSP/DAP/Linters
            { 'williamboman/mason.nvim', config = true }, -- config = true roda o setup() padrão
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = {
                    library = {
                        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                    },
                },
            },
        },
        config = function()
            -- 1. Definição dos Servidores e Configurações Específicas
            -- Se a chave existir aqui, o Mason vai instalar e usar essa config.
            -- Se não, ele usa a configuração padrão do lspconfig.
            local servers = {
                bashls = {},
                clangd = {}, -- Ótimo para seu C
                pyright = {},
                jdtls = {},  -- Java (Nota: nvim-jdtls é melhor para projetos complexos, mas jdtls puro funciona)
                ts_ls = {},  -- Antigo tsserver
                sqlls = {},
                -- nil_ls = {}, -- Nix

                -- Configuração específica do Lua LS
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            telemetry = { enable = false },
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
            }

            -- 2. Ferramentas que não são LSPs (Formatadores, Linters)
            -- O mason-lspconfig não instala isso, então usamos o tool-installer
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua',             -- Formatter Lua
                'shellcheck',         -- Linter Bash
                'shfmt',              -- Formatter Bash
                'editorconfig-checker',
                'prettier',           -- Formatter Web
            })

            require('mason-tool-installer').setup({ ensure_installed = ensure_installed, integrations = {['mason-lspconfig'] = true }})

            -- 3. Configuração Automática (Handlers)
            require('mason-lspconfig').setup({
                automatic_enable = true
                -- handlers = {
                --     function(server_name)
                --         local server_config = servers[server_name] or {}
                --
                --         -- Isso garante que as "capabilities" (como autocompletar) sejam passadas
                --         -- Se você usar nvim-cmp no futuro, adicione a linha abaixo:
                --         -- server_config.capabilities = require('cmp_nvim_lsp').default_capabilities()
                --
                --         vim.lsp.config(server_name, server_config)
                --         vim.lsp.enable(server_name)
                --     end,
                -- }
            })

            -- 4. Configuração de Diagnósticos (Visual)
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

            -- -- Define os ícones na calha (gutter)
            -- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " } -- Coloque ícones se quiser
            -- for type, icon in pairs(signs) do
            --     local hl = "DiagnosticSign" .. type
            --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            -- end
        end,
    },
}
