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

        if v.x > 0 then
          v.x = v.x - fric * dt
          if v.x < 0 then
            v.x = 0
          end 
        elseif v.x < 0 then
          v.x = v.x + fric * dt
          if v.x > 0 then
            v.x = 0
          end
        end
       --v.y = v.y > 0 and v.y - fric * dt or v.y < 0 and v.y + fric * dt or 0
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 function FrictionSystem:draw()
  local e
  for i = 1, self.pool.size do
     e = self.pool:get(i)
     
     local v = e:get(C.Velocity)
     local f = e:get(C.Friction)

     love.graphics.print("velocity: "..v.x.."; "..v.y, 0, 24)
     --v.y = v.y > 0 and v.y - fric * dt or v.y < 0 and v.y + fric * dt or 0
  end 
  -- Alternatively:
  -- for _, e in ipairs(self.pool.objects) do
end

 return FrictionSystem