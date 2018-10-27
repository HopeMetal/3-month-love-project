local System = require("libs.Concord.system")
local C = require("Components")
local FrictionSystem = System({C.Velocity, C.Friction})

  function FrictionSystem:init(message)
    print(message)
 end
 
 function FrictionSystem:entityAdded(e)
    print(tostring(e).." was added to the Op System.")
 end
 
 function FrictionSystem:update(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local v = e:get(C.Velocity)
       local f = e:get(C.Friction)

       local fric = f.v
       
       v.x = v.x > 0 and v.x - fric * dt or v.x < 0 and v.x + fric * dt or 0
       v.y = v.y > 0 and v.y - fric * dt or v.y < 0 and v.y + fric * dt or 0
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return FrictionSystem