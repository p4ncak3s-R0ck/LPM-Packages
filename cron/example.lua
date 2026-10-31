local cron = require("cron")
local timer = cron.after(1, function() print("done") end)
timer:update(1)
