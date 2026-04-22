local packages = {}

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function parse_package_line(line)
    line = trim(line)

    if line == "" or line:match("^#") then
        return nil
    end

    -- remove comentário no final
    line = trim(line:gsub("%s+#.*$", ""))

    if line == "" then
        return nil
    end

    local repo, ref = line:match("^([^@]+)@(.+)$")

    if repo then
        return {
            src = "https://github.com/" .. trim(repo),
            version = trim(ref),
        }
    end

    return {
        src = "https://github.com/" .. line,
    }
end

for line in io.lines(vim.fn.stdpath('config') .. '/packages.txt') do
    local spec = parse_package_line(line)
    if spec then
        table.insert(packages, spec)
    end
end

-- debug
-- print(vim.inspect(packages))

vim.pack.add(packages)
