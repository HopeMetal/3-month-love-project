local System = require("libs.Concord.system")
local C = require("Components")
local CameraSystem = System({C.Position, C.Camera})

  function CameraSystem:init(message)
    print(message)
 end
 
 function CameraSystem:entityAdded(e)
    print(tostring(e).." was added to the Camera System.")
 end
 
 function CameraSystem:draw(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
       local pos = e:get(C.Position)

       love.graphics.translate(love.graphics.getWidth() / 2 - pos.x, love.graphics.getHeight()/2 - pos.y)
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 return CameraSystem