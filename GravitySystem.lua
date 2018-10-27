local System = require("libs.Concord.system")
local C = require("Components")
local GravitySystem = System({C.Acceleration, C.Gravity})

  function GravitySystem:init(message)
    print(message)
 end
 
 function GravitySystem:entityAdded(e)
    print(tostring(e).." was added to the gravity System.")
 end
 
 function GravitySystem:update(dt)
    --print("gravity update")
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local a = e:get(C.Acceleration)
       local g = e:get(C.Gravity)

       a.y = a.y + (g.g * math.sqrt(dt))/2
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return GravitySystem