local System = require("libs.Concord.system")
local C = require("Components")
local KeyPressedSystem = System({C.PlayerInput})

  function KeyPressedSystem:init(message)
    print(message)
 end
 
 function KeyPressedSystem:entityAdded(e)
    print(tostring(e).." was added to the System.")
 end
 
function KeyPressedSystem:keypressed(key)
    print(key, "pressed")
    if key == "escape" then
        love.event.quit()
    end
    if key == "r" then
        love.event.quit("restart")
    end
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
 
       local input = e:get(C.PlayerInput)
       input:registerKey(key, true)
    end
end

function KeyPressedSystem:keyreleased(key)
    print(key, "released")
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)
 
       local input = e:get(C.PlayerInput)
       input:registerKey(key, false)
    end
end

return KeyPressedSystem