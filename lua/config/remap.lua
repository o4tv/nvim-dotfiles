vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>wq", ":wq<CR>")
vim.keymap.set("n", "<leader>q", ":qa<CR>")
vim.keymap.set({"n", "i"}, "<C-s>", "<cmd>:w<CR>")
vim.keymap.set({"n", "i"}, "<M-q>", "<cmd>:q<CR>")

vim.keymap.set("n", "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end, { desc = "Toggle wrap" })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- hyprctl switchxkblayout by-tech-gaming-keyboard-1 next
vim.keymap.set({"n", "i", "v"}, "<C-i>", function()
    vim.system({"hyprctl", "switchxkblayout", "by-tech-gaming-keyboard", "next"})
    vim.system({"hyprctl", "switchxkblayout", "by-tech-gaming-keyboard-1", "next"})
end, { desc = "kb layout" })

local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', { noremap = true })
map('n', '<C-j>', '<C-w>j', { noremap = true })
map('n', '<C-k>', '<C-w>k', { noremap = true })
map('n', '<C-l>', '<C-w>l', { noremap = true })

map('n', '<C-Left>', '<C-w><', { noremap = true })
map('n', '<C-Down>', '<C-w>-', { noremap = true })
map('n', '<C-Up>', '<C-w>+', { noremap = true })
map('n', '<C-Right>', '<C-w>>', { noremap = true })

-- pros plugin ok
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").jump()
end, { desc = "Flash" })

-- vim.keymap.set({ "n", "x", "o" }, "S", function()
--   require("flash").treesitter()
-- end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function()
  require("flash").remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set("c", "<c-s>", function()
  require("flash").toggle()
end, { desc = "Toggle Flash Search" })


-- ~/.config/nvim/init.lua

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
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

vim.keymap.set("n", "<leader>pc", pack_clean)


vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })


