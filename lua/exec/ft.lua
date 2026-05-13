local filetypes = {
  python = function ()
    vim.opt_local.shiftwidth = 4
  end,
}

for ft, cb in pairs(filetypes) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = cb
  })
end
