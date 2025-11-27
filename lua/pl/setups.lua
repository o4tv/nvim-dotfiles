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

