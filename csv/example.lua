local csv = require("csv")
local encoded = csv.encode({{"name", "count"}, {"a,b", 3}})
for row in csv.openstring(encoded, {separator = ","}):lines() do
    print(table.concat(row, " | "))
end
