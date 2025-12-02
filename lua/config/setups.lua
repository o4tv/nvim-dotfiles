-- QOL
require("nvim-autopairs").setup({
    map_cr = true
})

require("toggleterm").setup({
    open_mapping = [[<C-\>]],
    size = 20
})

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
    -- vim.keymap.set('n', '<Esc>', api.tree.toggle,                       opts('Toggle'))
end
require("nvim-tree").setup({
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
})

-- funcionalidades
require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
})

require("markdown").setup({})

require("image").setup({
    backend = "kitty", -- or "ueberzug" or "sixel"
    processor = "magick_cli", -- or "magick_rock"
    integrations = {
        markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup", -- or "inline"
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
    },
})
require('gitsigns').setup{
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
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = 'próximo hunk' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = 'hunk anterior' })

    -- Actions
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage do hunk atual' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Reset do hunk atual' })

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Stage do trecho selecionado' })

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end, { desc = 'Reset do trecho selecionado' })

    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Stage do buffer inteiro' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Reset do buffer inteiro' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Preview do hunk atual' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'Preview inline do hunk atual' })

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end, { desc = 'Blame completo da linha atual' })

    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Diff do arquivo atual' })

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end, { desc = 'Diff contra o commit anterior' })

    map('n', '<leader>hQ', function()
      gitsigns.setqflist('all')
    end, { desc = 'Enviar todos os hunks para a quickfix list' })

    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'Enviar hunks do buffer para a quickfix list' })

    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Ativar/desativar blame inline' })
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Ativar/desativar diff por palavra' })

    -- Text object
    map({'o', 'x'}, 'ih', gitsigns.select_hunk, { desc = 'Selecionar hunk como text object' })
  end
}

-- style
require("dashboard").setup({
    theme = 'hyper',
    config = {
        -- header = {
        --     "abu"
        -- },
        packages = { enable = false },
        week_header = {
            enable = true,
        },
        shortcut = {
            {
                desc = 'live grep',
                action = 'Telescope live_grep',
                key = 's',
            },
            {
                desc = 'files',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = 'quit',
                action = 'q',
                key = 'q',
            }
        },
        footer = {},
    },

})

require("lualine").setup({
    options = {
        theme = 'ayu_mirage',
        globalstatus = true,
    },
    sections = {
        lualine_x = {'buffers', 'encoding', 'fileformat', 'filetype'},
    }
})

require("barbar").setup({
    sidebar_filetypes = {
        NvimTree = true
    }
})

