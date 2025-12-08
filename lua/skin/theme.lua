require('tokyonight').setup({
    transparent = true,
    styles = {
        sidebars = 'transparent',
        floats = 'transparent',
    },
})

vim.cmd.colorscheme('tokyonight')
require('colorizer').setup()
require('skin.transparency')
require('skin.dashboard')
require('skin.lualine')
