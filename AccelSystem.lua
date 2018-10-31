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

       if a.energyX > 0 then
        a.energyX = a.energyX - 640 * dt
        a.x = 640 * dt
        if a.energyX < 0 then
          a.energyX = 0
          a.x = 0
        end
       end

       if a.energyX < 0 then
        a.energyX = a.energyX + 640 * dt
        a.x = -640 * dt
        if a.energyX > 0 then
          a.energyX = 0
          a.x = 0
        end
       end

       if a.energyY < 0 then
        a.energyY = a.energyY + 640 * dt
        a.y = -640 * dt
        if a.energyY > 0 then
          a.energyY = 0
          a.y = 0
        end
       end
       
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