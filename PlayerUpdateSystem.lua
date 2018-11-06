local System = require("libs.Concord.system")
local C = require("Components")
local RectUpdateSystem = System({C.Acceleration, C.Position, C.Velocity, C.Rect, C.PlayerInput})

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
       local p = e:get(C.Position)
       local v = e:get(C.Velocity)

       local arate = input.arate * dt
       local energyX = input.arate * dt
       local energyY = input.arate
       --print(v)
       --print(v.x)
       if input.pressedKeys["left"] then
        --a.x = -arate
        a.energyX = -arate
       end
       if input.pressedKeys["right"]then
        --a.x = arate
        a.energyX = arate
       end
       if input.pressedKeys["z"] then
        if input.onGround then
          --a.y = -arate * 10
          local extraV = 0
          input.onGround = false
          --[[if input.groundVelocity then
            extraV = input.groundVelocity.y
          end]]
          v.y = -input.arate / 2.5 + extraV
          e:get(C.Gravity).g = 1
          --[[if input.groundPosition then
            p.y = input.groundPosition.y + extraV * dt - e:get(C.Rect).h
          end]]
          --[[if input.groundVelocity then
            p.y = p.y + input.groundVelocity.y * dt
          end]]
          --a.energyY = -arate * 20
        end
       end
       if input.pressedKeys["down"] then
        --a.y = arate
       end

       if a.energyX > 0 then
        a.energyX = a.energyX - arate
        a.x = arate
        if a.energyX < 0 then
          a.energyX = 0
          a.x = 0
        end
       end

       if a.energyX < 0 then
        a.energyX = a.energyX + arate
        a.x = -arate
        if a.energyX > 0 then
          a.energyX = 0
          a.x = 0
        end
       end

      --[[ if a.energyY < 0 then
        a.energyY = a.energyY + arate
        a.y = -arate
        if a.energyY > 0 then
          a.energyY = 0
          a.y = 0
        end
       end]]

       --print(a.x, a.y)
    end
 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return RectUpdateSystem