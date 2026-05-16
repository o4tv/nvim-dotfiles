local M = {}

if vim.g.layout_configs == nil then
  vim.g.layout_configs = {}
end

local registry = {}

local function update_global_config(id, value)
  local configs = vim.g.layout_configs
  configs[id] = value
  vim.g.layout_configs = configs
end

--- Função para definir explicitamente o estado de um layout sync
--- @param id string O nome do layout (ex: "canary", "portuguese")
--- @param state boolean true para ligar, false para desligar
function M.set(id, state)
  id = string.lower(id)
  local layout = registry[id]

  if not layout then
    vim.notify("Layout sync '" .. id .. "' não está registrado.", vim.log.levels.ERROR)
    return
  end

  update_global_config(id, state)

  if state then
    layout.sync_fn() -- Roda a função de sincronização registrada
    vim.notify(layout.name .. " sync: ON", vim.log.levels.INFO)
  else
    layout.reset_fn() -- Limpa o estado aplicado para forçar re-sincronização quando religar
    vim.notify(layout.name .. " sync: OFF", vim.log.levels.WARN)
  end
end

--- Função para alternar (toggle) o estado de um layout sync
--- @param id string O nome do layout
function M.toggle(id)
  id = string.lower(id)
  local current_state = vim.g.layout_configs[id]
  
  -- Reutiliza a função set invertendo o estado atual
  M.set(id, not current_state)
end

--- Registra e cria as configurações de um novo layout
function M.create_toggle(opts)
  local id = string.lower(opts.name)
  
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

  -- Registra as funções internas no 'registry' para que M.set e M.toggle possam usá-las
  registry[id] = {
    name = opts.name,
    sync_fn = sync_layout,
    reset_fn = function() state.applied = nil end,
  }

  -- Cria os comandos do Neovim usando as novas funções expostas
  vim.api.nvim_create_user_command(opts.name .. "Toggle", function() M.toggle(id) end, {})
  
  -- Bônus: Agora é trivial criar comandos para Setar explicitamente
  vim.api.nvim_create_user_command(opts.name .. "On", function() M.set(id, true) end, {})
  vim.api.nvim_create_user_command(opts.name .. "Off", function() M.set(id, false) end, {})

  if opts.keymap then
    vim.keymap.set("n", opts.keymap, function() M.toggle(id) end, { desc = "Toggle " .. opts.name })
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
  cmd_fn = function(v) return { "/home/tabin/.local/bin/hyprkan", "-p", "7071", "--change-layer", v } end,
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
