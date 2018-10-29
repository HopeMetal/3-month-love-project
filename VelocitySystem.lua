local System = require("libs.Concord.system")
local C = require("Components")
local VelocitySystem = System({C.World, "world"}, {C.Position, C.Velocity, "bodies"})

  function VelocitySystem:init(message)
    print(message)
 end
 
 function VelocitySystem:entityAdded(e)
    print(tostring(e).." was added to the Op System.")
 end

 local function filter(item, other)
  if item:has(C.Bounce) then
    return "bounce"
  else
    return "slide"
  end
 end
 
 function VelocitySystem:update(dt)
    local e
    local w = self.world:get(self.world.size):get(C.World).w
    for i = 1, self.bodies.size do
       e = self.bodies:get(i)
       
       local p = e:get(C.Position)
       local v = e:get(C.Velocity)
       
       local actualX, actualY, cols, len = w:move(e, p.x + v.x * dt, p.y + v.y * dt)
       for c = 1, len do
        local item = cols[c].item
        local other = cols[c].other
        --print("item "..tostring(item).." collided with "..tostring(other))
        local pitem = item:get(C.Position)
        local pother = other:get(C.Position)
        local rectother = other:get(C.Rect)
        
        if item:has(C.Bounce) then
          local bounce = item:get(C.Bounce)
          if pitem.x < pother.x then
            v.x = v.x - bounce.b
          elseif
          pitem.x > pother.x + rectother.w then
            v.x = v.x + bounce.b
          end
          v.y = v.y - bounce.b
        end
       end

       p.x = actualX
       p.y = actualY
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return VelocitySystem