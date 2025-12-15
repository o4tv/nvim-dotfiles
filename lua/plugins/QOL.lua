return {
    { 'windwp/nvim-autopairs', opts = {} },
    { 'kylechui/nvim-surround', opts = {} },
    {
        'nvim-tree/nvim-tree.lua',
        lazy = false,
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            -- disable_netrw = true,
            -- hijack_netrw = true,
            hijack_netrw = true,
            hijack_directories = {
                enable = true,
                auto_open = true,
            },
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')

                local function opts(desc)
                    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            end,
            view = {
                width = 25,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
        },
        keys = {
            {
                '<leader>e',
                function()
                    require('nvim-tree.api').tree.toggle()
                end,
                desc = 'Explorer',
                -- icon = '📁',
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'ahmedkhalf/project.nvim',
        },
        opts = {
            defaults = {
                layout_config = {
                    mirror = true,
                    horizontal = {
                        preview_width = 0.6,
                    },
                },
            },
        },
        config = function(_, opts)
            require('telescope').setup(opts)
            require('telescope').load_extension('projects')
            require('project_nvim').setup({})
        end,
        keys = {
            { '<leader>f', desc = 'file/find' },

            {
                '<leader>ff',
                function()
                    require('telescope.builtin').find_files()
                end,
                desc = 'Find Files',
            },
            {
                '<leader><leader>',
                function()
                    -- CORREÇÃO EXTRA: O parâmetro hidden vai aqui dentro
                    require('telescope.builtin').find_files({ hidden = true })
                end,
                desc = 'Find Files (Hidden)',
            },
            {
                '<leader>fg',
                function()
                    require('telescope.builtin').live_grep()
                end,
                desc = 'Live Grep',
            },
            {
                '<leader>fb',
                function()
                    require('telescope.builtin').buffers()
                end,
                desc = 'Buffers',
            },
            {
                '<leader>fh',
                function()
                    require('telescope.builtin').help_tags()
                end,
                desc = 'Help Tags',
            },
            {
                '<leader>fr',
                function()
                    require('telescope.builtin').oldfiles()
                end,
                desc = 'Recent Files',
            },
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            preset = 'helix',
        },
        keys = {
            -- { '<leader>k', desc = 'which-key', hidden = true },
            {
                '<leader>k?',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
            {
                '<leader>k!',
                function()
                    require('which-key').show({ global = true })
                end,
                desc = 'Buffer Global Keymaps (which-key)',
            },
        },
    },
    {
        'Wansmer/treesj',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            use_default_keymaps = false,
        },
        keys = {
            { '<leader>c', desc = 'code' },
            { '<leader>ct', desc = 'tree sj' },

            -- Treesj
            {
                '<leader>ctm',
                function()
                    require('treesj').toggle()
                end,
                desc = 'Toggle Split/Join',
            },
            {
                '<leader>ctr',
                function()
                    require('treesj').toggle({ split = { recursive = true } })
                end,
                desc = 'Split/Join recursively',
            },
            {
                '<leader>cts',
                function()
                    require('treesj').split()
                end,
                desc = 'Split code block',
            },
            {
                '<leader>ctj',
                function()
                    require('treesj').join()
                end,
                desc = 'Join code block',
            },
        },
    },
    {
        'abecodes/tabout.nvim',
        opts = {
            tabkey = '<C-Tab>', -- key to trigger tabout, set to an empty string to disable
            backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
            act_as_tab = true, -- shift content if tab out is not possible
            act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
            default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
            default_shift_tab = '<C-d>', -- reverse shift default action,
            enable_backwards = true, -- well ...
            completion = true, -- if the tabkey is used in a completion pum
            tabouts = {
                { open = "'", close = "'" },
                { open = '"', close = '"' },
                { open = '`', close = '`' },
                { open = '(', close = ')' },
                { open = '[', close = ']' },
                { open = '{', close = '}' },
            },
            ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
            exclude = {}, -- tabout will ignore these filetypes
        },
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                'S',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        '3rd/image.nvim',
        opts = {
            backend = 'kitty', -- or "ueberzug" or "sixel"
            kitty_method = 'normal',
            processor = 'magick_cli', -- or "magick_rock"
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    only_render_image_at_cursor_mode = 'popup', -- or "inline"
                    floating_windows = false, -- if true, images will be rendered in floating markdown windows
                    filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                },
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = 'próximo hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = 'hunk anterior' })

                -- Actions
                map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage do hunk atual' })
                map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset do hunk atual' })

                map('v', '<leader>gs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Stage do trecho selecionado' })

                map('v', '<leader>gr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end, { desc = 'Reset do trecho selecionado' })

                map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage do buffer inteiro' })
                map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset do buffer inteiro' })
                map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview do hunk atual' })
                map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = 'Preview inline do hunk atual' })

                map('n', '<leader>gb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = 'Blame completo da linha atual' })

                map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff do arquivo atual' })

                map('n', '<leader>gD', function()
                    gitsigns.diffthis('~')
                end, { desc = 'Diff contra o commit anterior' })

                map('n', '<leader>gQ', function()
                    gitsigns.setqflist('all')
                end, { desc = 'Enviar todos os hunks para a quickfix list' })

                map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Enviar hunks do buffer para a quickfix list' })

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Ativar/desativar blame inline' })
                map('n', '<leader>td', gitsigns.toggle_word_diff, { desc = 'Ativar/desativar diff por palavra' })

                -- Text object
                map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Selecionar hunk como text object' })
            end,
        },
        keys = {
            { '<leader>g', desc = 'git' },
        },
    },
}
