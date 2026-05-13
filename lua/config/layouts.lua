local M = {}

-- Inicializa a tabela global única se ela não existir
if vim.g.layout_configs == nil then
  vim.g.layout_configs = {}
end

--- Função auxiliar para atualizar um valor dentro da tabela global do Neovim
--- Como tabelas no vim.g são imutáveis na atribuição direta de campos,
--- precisamos reatribuir a tabela inteira ou usar uma variável local.
local function update_global_config(key, value)
  local configs = vim.g.layout_configs
  configs[key] = value
  vim.g.layout_configs = configs
end

function M.create_toggle(opts)
  local id = string.lower(opts.name)
  
  -- Define o estado inicial se não houver
  if vim.g.layout_configs[id] == nil then
    update_global_config(id, false)
  end

  local state = { applied = nil }

  local function set_layout(val)
    if state.applied == val then return end
    state.applied = val
    vim.fn.jobstart(opts.cmd_fn(val))
  end

  local function sync_layout()
    -- Busca o status atualizado na tabela global
    if not vim.g.layout_configs[id] then
      state.applied = nil
      return
    end

    local mode = vim.fn.mode(1)
    if mode:match("^[iR]") then
      set_layout(opts.val_insert)
    else
      set_layout(opts.val_normal)
    end
  end

  local function toggle_fn()
    local current_status = vim.g.layout_configs[id]
    update_global_config(id, not current_status)

    if vim.g.layout_configs[id] then
      sync_layout()
      vim.notify(opts.name .. " sync: ON", vim.log.levels.INFO)
    else
      state.applied = nil
      vim.notify(opts.name .. " sync: OFF", vim.log.levels.WARN)
    end
  end

  -- Registro de Comandos, Keymaps e Autocmds (mesma lógica anterior)
  vim.api.nvim_create_user_command(opts.name .. "Toggle", toggle_fn, {})
  
  if opts.keymap then
    vim.keymap.set("n", opts.keymap, toggle_fn, { desc = "Toggle " .. opts.name })
  end

  local group = vim.api.nvim_create_augroup(opts.name .. "SyncGroup", { clear = true })
  vim.api.nvim_create_autocmd({ "ModeChanged", "VimEnter" }, {
    group = group,
    callback = sync_layout,
  })
end

-- Kanata
M.create_toggle({
  name = "Canary",
  cmd_fn = function(v) return { "/home/tabin/.local/bin/kanata_layer", v } end,
  val_insert = "canary",
  val_normal = "qwerty",
  keymap = "<leader>tlc"
})

-- Hyprland
M.create_toggle({
  name = "Portuguese",
  cmd_fn = function(v) return { "hyprctl", "switchxkblayout", "all", tostring(v) } end,
  val_insert = 1,
  val_normal = 0,
  keymap = "<leader>tlp"
})

return M
