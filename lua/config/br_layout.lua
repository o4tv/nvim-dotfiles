-- aviso: vibecodado

local M = {}

vim.g.portuguese = false

local state = {
  applied = nil, -- 0 = us, 1 = br
}

local function hypr_set_layout(idx)
  if state.applied == idx then
    return
  end

  state.applied = idx

  -- use "all" se quiser trocar em todos os teclados
  -- use "current" se quiser só no teclado principal do Hyprland
  vim.fn.jobstart({ "hyprctl", "switchxkblayout", "all", tostring(idx)}) 
end

local function sync_layout()
  if not vim.g.portuguese then
    -- desligado = não muda nada
    state.applied = nil
    return
  end

  local mode = vim.fn.mode(1)

  -- insert / replace / virtual replace => BR
  if mode:match("^[iR]") then
    hypr_set_layout(1) -- br
  else
    hypr_set_layout(0) -- us
  end
end

function M.toggle()
  vim.g.portuguese = not vim.g.portuguese

  if vim.g.portuguese then
    sync_layout()
    vim.notify("Portuguese layout sync: ON")
  else
    state.applied = nil
    vim.notify("Portuguese layout sync: OFF")
  end
end

vim.api.nvim_create_user_command("PortugueseToggle", function()
  M.toggle()
end, {})

vim.keymap.set("n", "<leader>tp", function()
  M.toggle()
end, { desc = "Toggle portuguese layout sync" })

local group = vim.api.nvim_create_augroup("PortugueseLayoutSync", { clear = true })

vim.api.nvim_create_autocmd({ "ModeChanged", "VimEnter" }, {
  group = group,
  callback = function()
    sync_layout()
  end,
})

return M
