local System = require("libs.Concord.system")
local C = require("Components")
local RectDrawSystem = System({C.Rect, C.Position})

  function RectDrawSystem:init(message)
    print(message)
    self.traceCanvas = love.graphics.newCanvas()
 end
 
 function RectDrawSystem:entityAdded(e)
    print(tostring(e).." was added to the System.")
 end
 
 function RectDrawSystem:draw()
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
 
       local r = e:get(C.Rect)
       local p = e:get(C.Position)
       --print(r.w, r.h)
--[[
       love.graphics.setCanvas(self.traceCanvas)
       love.graphics.setColor(1, 0, 0, 0.4)
       love.graphics.rectangle("fill", p.x, p.y, 2, 2)
       love.graphics.setCanvas()
       love.graphics.setColor(1, 1, 1, 1)
       love.graphics.draw(self.traceCanvas, 0, 0)
  ]]
       love.graphics.setColor(0, 1, 0)
       love.graphics.rectangle("fill", p.x, p.y, r.w, r.h)
       love.graphics.setColor(1, 1, 1)

    end
 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return RectDrawSystem