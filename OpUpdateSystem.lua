local System = require("libs.Concord.system")
local C = require("Components")
local OpUpdateSystem = System({C.Rect, C.Position, C.Velocity, C.Acceleration, C.Op})

  function OpUpdateSystem:init(message)
    print(message)
 end
 
 function OpUpdateSystem:entityAdded(e)
    print(tostring(e).." was added to the Op System.")
 end
 
 function OpUpdateSystem:update(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local p = e:get(C.Position)
       p.y = p.y + 40 * dt
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return OpUpdateSystem