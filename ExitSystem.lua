local System = require("libs.Concord.system")
local C = require("Components")
local ExitSystem = System({C.Position, C.Exit, C.BumpSensor, "exits"}, {C.Time, "time"})

  function ExitSystem:init(message)
    print(message)
 end
 
 function ExitSystem:entityAdded(e)
    print(tostring(e).." was added to the Exit System.")
 end
 
 function ExitSystem:update(dt)
    local e
    for i = 1, self.exits.size do
       e = self.exits:get(i)
       local sensor = e:get(C.BumpSensor)

       if sensor.on then
        local time = self.time:get(1):get(C.Time)
        
        time.active = false
       end
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return ExitSystem