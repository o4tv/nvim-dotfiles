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
