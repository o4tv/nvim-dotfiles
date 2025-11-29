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

require('render-markdown').setup({
    completions = { lsp = { enabled = true } },
})

require("markdown").setup({})

-- local wk = require("which-key")
-- wk.add({
--     {
--         "<leader>?",
--         function()
--             require("which-key").show({ global = false })
--         end,
--         desc = "Buffer Local Keymaps (which-key)",
--     },
-- })

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

