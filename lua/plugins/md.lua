return {
    { 'tadmccorkle/markdown.nvim', config = true },
    { 'MeanderingProgrammer/render-markdown.nvim', opts = { lsp = { enabled = true } } },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && npm install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
        keys = {
            { '<leader>tm', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Markdown Preview' },
        },
    },
}
