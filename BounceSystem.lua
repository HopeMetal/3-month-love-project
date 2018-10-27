local System = require("libs.Concord.system")
local C = require("Components")
local BounceSystem = System({C.Velocity, C.Bounce})

  function BounceSystem:init(message)
    print(message)
 end
 
 function BounceSystem:entityAdded(e)
    print(tostring(e).." was added to the bounce System.")
 end
 
 function BounceSystem:update(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local v = e:get(C.Velocity)
       local b = e:get(C.Bounce)
       v.y = v.y - b.b
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return BounceSystem