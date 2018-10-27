local System = require("libs.Concord.system")
local C = require("Components")
local AccelSystem = System({C.Velocity, C.Acceleration})

  function AccelSystem:init(message)
    print(message)
 end
 
 function AccelSystem:entityAdded(e)
    print(tostring(e).." was added to the accel System.")
 end
 
 function AccelSystem:update(dt)
    --print("accel update")
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local a = e:get(C.Acceleration)
       local v = e:get(C.Velocity)

       local maxvel = v.max
       
       if v.x > -maxvel then
        v.x = v.x + a.x
       else
        v.x = -maxvel
       end
       if v.x < maxvel then
        v.x = v.x + a.x
       else
        v.x = maxvel
       end
       if v.y > -maxvel then
        v.y = v.y + a.y
       else
        v.y = -maxvel
       end
       if v.y < maxvel then
        v.y = v.y + a.y
       else
        v.y = maxvel
       end

       a.x = 0
       a.y = 0
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return AccelSystem