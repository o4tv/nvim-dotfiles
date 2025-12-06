local packages = {}
for line in io.lines(vim.fn.stdpath('config') .. '/packages.txt') do
    table.insert(packages, { src = 'https://github.com/' .. line })
end
---- debug
-- print(vim.inspect(packages))
vim.pack.add(packages)
