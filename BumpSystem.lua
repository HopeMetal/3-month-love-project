--[[

  This system is basically the collision system.
]]


local System = require("libs.Concord.system")
local bump = require("libs.bump")
local C = require("Components")
local BumpSystem = System({C.World, "world"}, {C.Rect, C.Position, "bodies"}, {C.BumpSensor, "sensors"})

  function BumpSystem:init(message)
    print(message)
    self.bodiesToAdd = {}
    self.sensorsToAdd = {}
 end
 
 function BumpSystem:entityAdded(e)
    print(tostring(e).." was added to the Bump System.")
 end

 function BumpSystem:entityAddedTo(e, pool)
  print(tostring(e).." was added to the Bump System. Pool: "..tostring(pool.name))
  if pool.name == "world" then
    e:get(C.World).w = bump.newWorld()
    print(e.w)
  elseif
     pool.name == "bodies" then
      table.insert(self.bodiesToAdd, e)
     --self.bodiesToAdd[#self.bodiesToAdd + 1] = e
  elseif
      pool.name == "sensors" then
        table.insert(self.sensorsToAdd, e)
      end
 end
 
 local function filter(item, other)
  if item.name == "BumpSensor" or other.name == "BumpSensor" then
    return false
  else
    return "slide"
  end
 end
 

 function BumpSystem:update(dt)
    local e
    local ind
    local world = self.world:get(self.world.size):get(C.World).w
    --add bodies to world
    while #self.bodiesToAdd > 0 do
      ind = #self.bodiesToAdd
       e = self.bodiesToAdd[#self.bodiesToAdd]
       local r = e:get(C.Rect)
       local p = e:get(C.Position)

       world:add(e, p.x, p.y, r.w, r.h)
       print("adding rect from entity "..tostring(v))
       table.remove(self.bodiesToAdd)
    end
    --add sensors to world
    while #self.sensorsToAdd > 0 do
      ind = #self.sensorsToAdd
       e = self.sensorsToAdd[#self.sensorsToAdd]
       local r = e:get(C.Rect)
       local p = e:get(C.Position)
        local s = e:get(C.BumpSensor)

       world:add(s, p.x + s.x, p.y + s.y, s.w, s.h)
       print("adding rect from entity "..tostring(v))
       table.remove(self.sensorsToAdd)
    end
    --update all the bodies with a non zero velocity
    for i = 1, self.bodies.size do
      e = self.bodies:get(i)
      
      local p = e:get(C.Position)
      if e:has(C.Velocity) then
        local v = e:get(C.Velocity)
        if v.x ~= 0 or v.y ~= 0 then
          local actualX, actualY, cols, len = world:move(e, p.x + v.x * dt, p.y + v.y * dt, filter)
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
      end
      --update all active sensors
      for s = 1, self.sensors.size do
        local entity = self.sensors:get(s)
        local sensor = entity:get(C.BumpSensor)
        local p = entity:get(C.Position)

        world:update(sensor, p.x + sensor.x, p.y + sensor.y)
        local _, __, cols, len = world:check(sensor, p.x + sensor.x, p.y + sensor.y)
        if len > 0 then
          sensor.on = true
        else
          sensor.on = false
        end
      end
   end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 function BumpSystem:draw()
  love.graphics.setColor(1, 1, 1, 0.6)
  local w
  local e
    for i = 1, self.world.size do
      w = self.world:get(i):get(C.World).w
      
      for j = 1, self.bodies.size do
        e = self.bodies:get(j)
        print("drawing rect from entity "..tostring(e))
        local x, y, width, height = w:getRect(e)
        love.graphics.rectangle("line", x, y, width, height)
      end

      
      for j = 1, self.sensors.size do
        love.graphics.setColor(1, 0, 0, 0.6)
        e = self.sensors:get(j)
        local s = e:get(C.BumpSensor)
        if s.on then
          love.graphics.setColor(0, 0, 1, 0.6)
        end
        print("drawing rect from entity "..tostring(s))
        local x, y, width, height = w:getRect(s)
        love.graphics.rectangle("line", x, y, width, height)
      end
    end
  love.graphics.setColor(1, 1, 1, 1)
 end

 return BumpSystem