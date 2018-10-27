local System = require("libs.Concord.system")
local C = require("Components")
local RectUpdateSystem = System({C.Acceleration, C.PlayerInput, C.BumpSensor})

  function RectUpdateSystem:init(message)
    print(message)
 end
 
 function RectUpdateSystem:entityAdded(e)
    print(tostring(e).." was added to the System.")
 end
 
 function RectUpdateSystem:update(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       
       local a = e:get(C.Acceleration)
       local input = e:get(C.PlayerInput)
       local sensor = e:get(C.BumpSensor)

       local arate = input.arate * dt
       --print(v)
       --print(v.x)
       if input.pressedKeys["left"] then
        a.x = -arate
       end
       if input.pressedKeys["right"]then
        a.x = arate
       end
       if input.pressedKeys["z"] then
        if sensor.on then
          a.y = -arate * 100
        end
       end
       if input.pressedKeys["down"] then
        a.y = arate
       end

       --print(a.x, a.y)
    end
 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return RectUpdateSystem