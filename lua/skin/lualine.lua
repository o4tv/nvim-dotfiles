require('lualine').setup({
    options = {
        theme = 'ayu_mirage',
        globalstatus = true,
    },
    sections = {
        lualine_x = { 'buffers', 'encoding', 'fileformat', 'filetype' },
    },
})
