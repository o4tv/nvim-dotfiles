return {
    {
        'folke/tokyonight.nvim',
        dependencies = { 'norcalli/nvim-colorizer.lua' },
        lazy = false,
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = 'transparent',
                floats = 'transparent',
            },
        },
        config = function(_, opts)
        -- config = function()
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme('tokyonight')
            require('colorizer').setup()

            -- transparent background
            vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'Terminal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'FoldColumn', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'Folded', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'WhichKeyFloat', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = 'none' })

            -- transparent background for neotree
            vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NeoTreeVertSplit', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { bg = 'none' })

            -- transparent background for nvim-tree
            vim.api.nvim_set_hl(0, 'NvimTreeNormal', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NvimTreeVertSplit', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NvimTreeEndOfBuffer', { bg = 'none' })

            -- transparent notify background
            vim.api.nvim_set_hl(0, 'NotifyINFOBody', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyERRORBody', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyWARNBody', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyTRACEBody', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyDEBUGBody', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyINFOTitle', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyERRORTitle', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyWARNTitle', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyTRACETitle', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyDEBUGTitle', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyINFOBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyERRORBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyWARNBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyTRACEBorder', { bg = 'none' })
            vim.api.nvim_set_hl(0, 'NotifyDEBUGBorder', { bg = 'none' })
        end,
    },
    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-mini/mini.icons' },
        config = function()
            local dashboard = require('alpha.themes.dashboard')
            dashboard.section.header.val = {
                '▄▄▄█████▓ ▄▄▄    ██▒   █▓ ██▓ ███▄    █ ',
                '▓  ██▒ ▓▒▒████▄ ▓██░   █▒▓██▒ ██ ▀█   █ ',
                '▒ ▓██░ ▒░▒██  ▀█▄▓██  █▒░▒██▒▓██  ▀█ ██▒',
                '░ ▓██▓ ░ ░██▄▄▄▄██▒██ █░░░██░▓██▒  ▐▌██▒',
                '  ▒██▒ ░  ▓█   ▓██▒▒▀█░  ░██░▒██░   ▓██░',
                '  ▒ ░░    ▒▒   ▓▒█░░ ▐░  ░▓  ░ ▒░   ▒ ▒ ',
                '    ░      ▒   ▒▒ ░░ ░░   ▒ ░░ ░░   ░ ▒░',
                '  ░        ░   ▒     ░░   ▒ ░   ░   ░ ░ ',
                '               ░  ░   ░   ░           ░ ',
                '                     ░                  ',
            }
            dashboard.section.footer.val = {
                '                 ainn... nobru apelaoooo',
                ' ',
                '                         - Apelão, Nobru',
            }

            dashboard.section.buttons.val = {
                dashboard.button('f', '󰈞  ' .. 'find file', ':Telescope find_files<CR>'),
                dashboard.button('p', '  ' .. 'projects', ':Telescope projects<CR>'),
                dashboard.button('r', '  ' .. 'recent', ':Telescope oldfiles<CR>'),
                dashboard.button('h', '?  ' .. 'find help', ':Telescope help_tags<CR>'),
                dashboard.button('q', '󰩈  ' .. 'quit', ':qa<CR>'),
            }

            require('alpha').setup(dashboard.opts)
            vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'ayu_mirage',
                globalstatus = true,
            },
            sections = {
                lualine_x = { 'buffers', 'encoding', 'fileformat', 'filetype' },
            },
        },
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            sidebar_filetypes = {
                NvimTree = true,
            },
        },
        keys = {
            { '<leader>b', desc = 'buffers' },
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
        },
    },
}
