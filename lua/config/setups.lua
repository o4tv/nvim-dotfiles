-- QOL
require('nvim-autopairs').setup({})

require('toggleterm').setup({
    open_mapping = [[<C-\>]],
    size = 20,
})

local function my_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
    -- vim.keymap.set('n', '<Esc>', api.tree.toggle,                       opts('Toggle'))
end
require('nvim-tree').setup({
    on_attach = my_on_attach,
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
})

-- funcionalidades
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
})

require('markdown').setup()

require('image').setup({
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
})

require('gitsigns').setup({
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
})

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
vim.cmd([[
autocmd FileType alpha setlocal nofoldenable
]])

require('lualine').setup({
    options = {
        theme = 'ayu_mirage',
        globalstatus = true,
    },
    sections = {
        lualine_x = { 'buffers', 'encoding', 'fileformat', 'filetype' },
    },
})

require('barbar').setup({
    sidebar_filetypes = {
        NvimTree = true,
    },
})

require('nvim-surround').setup({})

require('colorizer').setup()

require('tabout').setup({
    tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
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
})

require('treesj').setup({
    use_default_keymaps = false,
})

require('telescope').load_extension('projects')
require('telescope').setup({
    defaults = {
        layout_config = {
            mirror = true,
            horizontal = {
                preview_width = 0.6,
            },
        },
    },
})
require('project_nvim').setup({})
