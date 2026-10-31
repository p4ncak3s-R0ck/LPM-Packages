-- LPM adapter: upstream lua-csv reader plus a local RFC-style CSV row encoder.
local csv = require("csv.reader")
function csv.encode(rows)
    assert(type(rows) == "table", "rows must be a table")
    local lines, width = {}, nil
    local function cell(v)
        local kind = type(v)
        assert(kind == "string" or kind == "number" or kind == "boolean", "CSV cells must be strings, finite numbers or booleans")
        assert(kind ~= "number" or (v == v and v ~= math.huge and v ~= -math.huge), "CSV numbers must be finite")
        local s = tostring(v)
        if s:find('[,\r\n"]') then s = '"' .. s:gsub('"', '""') .. '"' end
        return s
    end
    local count = #rows
    for key in pairs(rows) do
        assert(type(key) == "number" and key % 1 == 0 and key >= 1 and key <= count, "rows must be a dense array")
    end
    for index = 1, count do
        local row = rows[index]
        assert(type(row) == "table", "each row must be a table")
        width = width or #row
        local fields = {}
        for k in pairs(row) do assert(type(k) == "number" and k % 1 == 0 and k >= 1 and k <= width, "rows must be dense arrays of equal width") end
        assert(#row == width, "rows must have equal width")
        for i=1,width do assert(row[i] ~= nil, "rows must be dense"); fields[i] = cell(row[i]) end
        lines[#lines + 1] = table.concat(fields, ",")
    end
    return #lines > 0 and table.concat(lines, "\r\n") .. "\r\n" or ""
end
return csv
