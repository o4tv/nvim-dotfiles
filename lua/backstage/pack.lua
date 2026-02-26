local packages = {}
for line in io.lines(vim.fn.stdpath('config') .. '/packages.txt') do
    line = line:match("^%s*(.-)%s*$")
    if line ~= "" and not line:match("^#") then
        table.insert(packages, { src = 'https://github.com/' .. line })
    end
end
---- debug
-- print(vim.inspect(packages))
vim.pack.add(packages)
