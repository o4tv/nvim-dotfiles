require('blink.cmp').setup({
    keymap = {
        preset = 'enter',
        -- tab nao funciona sem isso, nao sei o porquê
        ["<Tab>"] = { vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true) },
    },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = false },
        accept = {
            auto_brackets = { enabled = true }
        },
    },
    sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
            snippets = {
                opts = {
                    friendly_snippets = true,
                }
            }
        },
    },
    fuzzy = { implementation = "lua" }

})


