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
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "lua" }

})


