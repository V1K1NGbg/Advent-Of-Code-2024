-- lua 24.1.lua

local input = assert(io.open("input/24.txt"))
local content = input:read("*a")
input:close()

local assignments, logic = string.match(content, "^(.+)\n\n(.+)$")

local function tsort(t, k, d)
    local values = {}
    local degrees = {}
    local blocklists = {}
    for _, value in ipairs(t) do
        local key = value[k]
        assert(values[key] == nil, "duplicate key")
        values[key] = value
        blocklists[key] = {}
    end
    local resolved = {}
    for key, value in pairs(values) do
        for _, dep in ipairs(value[d]) do
            local blocklist = blocklists[dep]
            if blocklist then
                table.insert(blocklist, key)
                degrees[key] = (degrees[key] or 0) + 1
            end
        end
        if not degrees[key] then
            table.insert(resolved, key)
        end
    end
    local index = 0
    while #resolved > 0 do
        local key = table.remove(resolved)
        local value = values[key]
        index = index + 1
        t[index] = value
        for _, dep in ipairs(blocklists[key]) do
            degrees[dep] = degrees[dep] - 1
            if degrees[dep] == 0 then
                table.insert(resolved, dep)
                degrees[dep] = nil
            end
        end
    end
    local cyclical
    for key in pairs(degrees) do
        cyclical = true
        index = index + 1
        t[index] = values[key]
    end
    return not cyclical
end

local inputs = {}
for line in string.gmatch(assignments, "[^\n]+") do
    local key, value = string.match(line, "^(%w+):%s+(%d)$")
    inputs[key] = tonumber(value)
end

local circuit, nodes = {}, {}
for line in string.gmatch(logic, "[^\n]+") do
    local op1, gate, op2, target = string.match(line, "^(%w+)%s(%w+)%s(%w+) %-> (%w+)$")
    local node = {
        op1 = op1,
        op2 = op2,
        gate = gate,
        target = target,
        deps = { op1, op2 }
    }
    table.insert(circuit, node)
    nodes[target] = node
end

local function run()
    if not tsort(circuit, "target", "deps") then
        return nil
    end
    local values = {}
    for key, value in pairs(inputs) do
        values[key] = value
    end
    for _, node in ipairs(circuit) do
        local value
        if node.gate == "AND" then
            value = values[node.op1] & values[node.op2]
        elseif node.gate == "OR" then
            value = values[node.op1]| values[node.op2]
        elseif node.gate == "XOR" then
            value = values[node.op1] ~ values[node.op2]
        end
        values[node.target] = value
    end
    return values
end

local function regvalue(prefix, values)
    local result = 0
    for i = 45, 0, -1 do
        result = (result << 1) | (values[string.format("%s%.2d", prefix, i)] or 0)
    end
    return result
end

print(regvalue("z", run()))
