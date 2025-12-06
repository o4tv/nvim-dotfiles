vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print('No unused plugins.')
        return
    end

    local choice = vim.fn.confirm('Remove unused plugins?', '&Yes\n&No', 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

local builtin = require('telescope.builtin')
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
        { 'S', require('flash').jump, desc = 'Flash', mode = { 'n', 'x', 'o' } },
        {
            '<leader>e',
            function()
                local api = require('nvim-tree.api')
                if vim.bo.filetype == 'NvimTree' then
                    api.tree.close()
                else
                    api.tree.focus()
                end
            end,
            desc = 'Explorer',
            icon = '📁',
        },
        { '<leader>f', group = 'file/find' },
        { '<leader>ff', builtin.find_files, desc = 'Find Files' },
        { '<leader><leader>', builtin.find_files, desc = 'Find Files', hidden = true },
        { '<leader>fg', builtin.live_grep, desc = 'Live Grep' },
        { '<leader>fb', builtin.buffers, desc = 'Buffers' },
        { '<leader>fh', builtin.help_tags, desc = 'Help Tags' },
        { '<leader>fr', builtin.oldfiles, desc = 'Recent Files' },
        { '<M-r>', builtin.oldfiles, desc = 'Recent Files', hidden = true },

        { '<leader>b', group = 'buffers' },
        -- Previous/next
        { '<A-h>', '<Cmd>BufferPrevious<CR>', desc = 'Buffer previous' },
        { '<A-l>', '<Cmd>BufferNext<CR>', desc = 'Buffer next' },
        -- Move
        { '<A-<>', '<Cmd>BufferMovePrevious<CR>', desc = 'Move buffer previous' },
        { '<A->>', '<Cmd>BufferMoveNext<CR>', desc = 'Move buffer next' },
        -- Goto buffer positions
        { '<A-1>', '<Cmd>BufferGoto 1<CR>', desc = 'Go to buffer 1' },
        { '<A-2>', '<Cmd>BufferGoto 2<CR>', desc = 'Go to buffer 2' },
        { '<A-3>', '<Cmd>BufferGoto 3<CR>', desc = 'Go to buffer 3' },
        { '<A-4>', '<Cmd>BufferGoto 4<CR>', desc = 'Go to buffer 4' },
        { '<A-5>', '<Cmd>BufferGoto 5<CR>', desc = 'Go to buffer 5' },
        { '<A-6>', '<Cmd>BufferGoto 6<CR>', desc = 'Go to buffer 6' },
        { '<A-7>', '<Cmd>BufferGoto 7<CR>', desc = 'Go to buffer 7' },
        { '<A-8>', '<Cmd>BufferGoto 8<CR>', desc = 'Go to buffer 8' },
        { '<A-9>', '<Cmd>BufferGoto 9<CR>', desc = 'Go to buffer 9' },
        -- Pin
        { '<A-p>', '<Cmd>BufferPin<CR>', desc = 'Toggle pin buffer' },
        -- Close
        { '<M-q>', '<Cmd>BufferClose<CR>', desc = 'Close buffer' },
        -- Pick mode
        { '<C-p>', '<Cmd>BufferPick<CR>', desc = 'Pick buffer' },
        { '<A-d>', '<Cmd>BufferPickDelete<CR>', desc = 'Pick buffer to delete' },
        -- Sort
        { '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', desc = 'Order by buffer number' },
        { '<leader>bn', '<Cmd>BufferOrderByName<CR>', desc = 'Order by name' },
        { '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', desc = 'Order by directory' },
        { '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', desc = 'Order by language' },
        { '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', desc = 'Order by window number' },

        { '<leader>c', group = 'code' },
        { '<leader>ct', group = 'tree sj' },

        -- Treesj
        { '<leader>ctm', require('treesj').toggle, desc = 'SoJ code block' },
        {
            '<leader>ctr',
            function()
                require('treesj').toggle({ split = { recursive = true } })
            end,
            desc = 'SoJ code block recursively',
        },
        { '<leader>cts', require('treesj').split, desc = 'Split code block' },
        { '<leader>ctj', require('treesj').join, desc = 'Join code block' },

        -- Conform
        {
            '<leader>cf',
            require('conform').format,
            desc = 'format code',
        },

        { '<leader>r', group = 'run', hidden = true },
        { '<leader>rr', '<cmd>restart<CR>', desc = 'restart' },
        { '<leader>rcd', '<cmd>cd %:p:h<CR>', desc = 'root dir on file dir' },
        { '<leader>rp', group = 'plugins' },
        { '<leader>rpc', pack_clean, desc = 'clear unused plugins' },

        { '<leader>t', group = 'toggle' },
        {
            '<leader>tw',
            function()
                vim.wo.wrap = not vim.wo.wrap
            end,
            desc = 'Toggle Wrap',
        },

        { '<leader>g', group = 'git' },
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

-- hyprctl switchxkblayout by-tech-gaming-keyboard-1 next
-- vim.keymap.set({ 'n', 'i', 'v' }, '<C-i>', function()
--     vim.system({ 'hyprctl', 'switchxkblayout', 'by-tech-gaming-keyboard', 'next' })
--     vim.system({ 'hyprctl', 'switchxkblayout', 'by-tech-gaming-keyboard-1', 'next' })
-- end, { desc = 'kb layout' })
