require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true },
        -- nix = { 'nixfmt' },
    },
})
