require('vim._core.ui2').enable({
    enable = true
})

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

require('markdown').setup({
    on_attach = function(bufnr)
      local map = vim.keymap.set
      local opts = { buffer = bufnr }
      map({ 'n', 'i' }, '<M-l><M-o>', '<Cmd>MDListItemBelow<CR>', opts)
      map({ 'n', 'i' }, '<M-L><M-O>', '<Cmd>MDListItemAbove<CR>', opts)
      map('n', '<M-c>', '<Cmd>MDTaskToggle<CR>', opts)
      map('x', '<M-c>', ':MDTaskToggle<CR>', opts)
    end,

})

-- require('image').setup({
--     backend = 'kitty', -- or "ueberzug" or "sixel"
--     kitty_method = 'normal',
--     processor = 'magick_cli', -- or "magick_rock"
--     integrations = {
--         markdown = {
--             enabled = true,
--             clear_in_insert_mode = false,
--             download_remote_images = true,
--             only_render_image_at_cursor = false,
--             only_render_image_at_cursor_mode = 'popup', -- or "inline"
--             floating_windows = false, -- if true, images will be rendered in floating markdown windows
--             filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
--         },
--     },
-- })

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

require('barbar').setup({
    sidebar_filetypes = {
        NvimTree = true,
    },
})

require('nvim-surround').setup({})

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

require('cord').setup({
  enabled = true,
  log_level = vim.log.levels.OFF,
  editor = {
    client = 'neovim',
    tooltip = 'https://github.com/o4tv',
    icon = nil,
  },
  display = {
    theme = 'default',
    flavor = 'dark',
    view = 'full',
    swap_fields = false,
    swap_icons = false,
  },
  timestamp = {
    enabled = true,
    reset_on_idle = false,
    reset_on_change = false,
    shared = false,
  },
  idle = {
    enabled = true,
    timeout = 30000,
    show_status = true,
    ignore_focus = true,
    unidle_on_focus = true,
    smart_idle = true,
    details = '💤',
    state = nil,
    tooltip = '💤',
    icon = nil,
  },
  text = {
    default = nil,
    workspace = function(opts) return 'in ' .. opts.workspace end,
    viewing = function(opts) return 'viewing ' .. opts.filename end,
    editing = function(opts) return 'editing ' .. opts.filename end,
    file_browser = function(opts) return 'browsing files' end,
    plugin_manager = function(opts) return 'managing plugins in ' .. opts.name end,
    lsp = function(opts) return 'configuring LSP in ' .. opts.name end,
    docs = function(opts) return 'reading ' .. opts.name end,
    vcs = function(opts) return 'committing changes in ' .. opts.name end,
    notes = function(opts) return 'taking notes in ' .. opts.name end,
    debug = function(opts) return 'debugging in ' .. opts.name end,
    test = function(opts) return 'testing in ' .. opts.name end,
    diagnostics = function(opts) return 'fixing problems in ' .. opts.name end,
    games = function(opts) return 'playing ' .. opts.name end,
    terminal = function(opts) return 'running shit on terminal' end,
    dashboard = 'home',
  }, 
  -- buttons = nil,
  buttons = {
    {
      label = 'view repo',
      -- url = function(opts) return opts.repo_url end,
      url = function(opts) return opts.repo_url end,
    },
  },
  assets = nil,
  variables = nil,
  hooks = {
    ready = nil,
    shutdown = nil,
    pre_activity = nil,
    post_activity = nil,
    idle_enter = nil,
    idle_leave = nil,
    workspace_change = nil,
    buf_enter = nil,
  },
  extensions = nil,
  advanced = {
    plugin = {
      autocmds = true,
      cursor_update = 'on_hold',
      match_in_mappings = true,
      debounce = {
        delay = 50,
        interval = 750,
      },
    },
    server = {
      update = 'fetch',
      pipe_path = nil,
      executable_path = nil,
      timeout = 300000,
    },
    discord = {
      pipe_paths = nil,
      reconnect = {
        enabled = false,
        interval = 5000,
        initial = true,
      },
      sync = {
        enabled = true,
        mode = 'periodic',
        interval = 12000,
        reset_on_update = true,
        pad = true,
      },
    },
    workspace = {
      root_markers = {
        '.git',
        '.hg',
        '.svn',
      },
      limit_to_cwd = false,
    },
  },
})

require('project_nvim').setup({})

require('uv').setup()

require('go').setup({})

