local moses = require("moses")
local doubled = moses.map({1, 2, 3}, function(v) return v * 2 end)
print(table.concat(doubled, ","))
