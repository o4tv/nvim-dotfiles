return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            javascript = { 'prettier', stop_after_first = true },
            typescript = { 'prettier', stop_after_first = true },
        },
    },
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format()
            end,
            desc = 'format code',
        },
    },
}
