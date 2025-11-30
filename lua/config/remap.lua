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
--- flash
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

-- limpar plugins não usados pelo vim.pack
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

--- toggle pro nvim tree
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')

--- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Telescope help tags' })

--- barbar
-- Move to previous/next
map('n', '<A-h>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true, desc = "Buffer previous" })
map('n', '<A-l>', '<Cmd>BufferNext<CR>',     { noremap = true, silent = true, desc = "Buffer next" })

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { noremap = true, silent = true, desc = "Move buffer previous" })
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>',     { noremap = true, silent = true, desc = "Move buffer next" })

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { noremap = true, silent = true, desc = "Go to buffer 1" })
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { noremap = true, silent = true, desc = "Go to buffer 2" })
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { noremap = true, silent = true, desc = "Go to buffer 3" })
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { noremap = true, silent = true, desc = "Go to buffer 4" })
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { noremap = true, silent = true, desc = "Go to buffer 5" })
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { noremap = true, silent = true, desc = "Go to buffer 6" })
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { noremap = true, silent = true, desc = "Go to buffer 7" })
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { noremap = true, silent = true, desc = "Go to buffer 8" })
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { noremap = true, silent = true, desc = "Go to buffer 9" })
map('n', '<A-0>', '<Cmd>BufferLast<CR>',   { noremap = true, silent = true, desc = "Go to last buffer" })

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', { noremap = true, silent = true, desc = "Toggle pin buffer" })

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', { noremap = true, silent = true, desc = "Close buffer" })

-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>',        { noremap = true, silent = true, desc = "Pick buffer" })
map('n', '<A-d>', '<Cmd>BufferPickDelete<CR>',  { noremap = false, silent = true, desc = "Pick buffer to delete" })

-- Sort automatically by...
map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { noremap = true, silent = true, desc = "Order by buffer number" })
map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>',         { noremap = true, silent = true, desc = "Order by name" })
map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>',    { noremap = true, silent = true, desc = "Order by directory" })
map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>',     { noremap = true, silent = true, desc = "Order by language" })
map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { noremap = true, silent = true, desc = "Order by window number" })

