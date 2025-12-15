local wk = require('which-key')

wk.add({
    {
        mode = { 'n' },
        { 'q', '<cmd>q<CR>', desc = 'quit' },
        { 'Q', '<cmd>qa<CR>', desc = 'Quit' },
        { 'Ç', ':', desc = 'maldito layout brasileiro' },
        { '<leader>w', '<cmd>w<CR>', desc = 'Buffer Write', hidden = true },
        { '<M-S-c>', '"+yy', desc = 'copy line to system' },
        { '<M-S-x>', '"+dd', desc = 'cut line to system' },
        { '<Esc>', '<cmd>nohlsearch<CR>', desc = 'clear highlight search' },
        { '<C-h>', '<C-w>h', desc = 'goto the left window' },
        { '<C-j>', '<C-w>j', desc = 'goto the down window' },
        { '<C-k>', '<C-w>k', desc = 'goto the up window' },
        { '<C-l>', '<C-w>l', desc = 'goto the right window' },
        { '<C-Left>', '<C-w><', desc = 'decrease width' },
        { '<C-Down>', '<C-w>-', desc = 'descrease height' },
        { '<C-Up>', '<C-w>+', desc = 'increase height' },
        { '<C-Right>', '<C-w>>', desc = 'increase width' },

        { '<leader>r', group = 'run', hidden = true },
        { '<leader>rr', '<cmd>restart<CR>', desc = 'restart' },
        { '<leader>rcd', '<cmd>cd %:p:h<CR>', desc = 'root dir on file dir' },
        { '<leader>rp', group = 'plugins' },

        { '<leader>t', group = 'toggle' },
        {
            '<leader>tw',
            function()
                vim.wo.wrap = not vim.wo.wrap
            end,
            desc = 'Toggle Wrap',
        },

    },
    {
        mode = { 'v' },
        { 'J', ":m '>+1<CR>gv=gv", desc = 'move line up' },
        { 'K', ":m '>+1<CR>gv=gv", desc = 'move line up' },
    },
    {
        mode = { 'i', 'v' },
        { '<M-S-c>', '"+y', desc = 'copy selection to system' },
        { '<M-S-x>', '"+d', desc = 'cut selection to system' },
    },

})
