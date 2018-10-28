local System = require("libs.Concord.system")
local C = require("Components")
local TimeSystem = System({C.Time})

  function TimeSystem:init(message)
    print(message)
 end
 
 function TimeSystem:entityAdded(e)
    print(tostring(e).." was added to the Time System.")
 end
 
 function TimeSystem:update(dt)
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)

       local time = e:get(C.Time)
    
       if time.active then
        if time.s == 60 then
                time.m = time.m + 1
                time.s = 0
        end
        if time.dtpassed > 1 then
                time.dtpassed = time.dtpassed - 1
                time.s = time.s + 1
        end 

        time.dtpassed = time.dtpassed + dt
       end
    end 
 end

 function TimeSystem:draw()
    local e
    for i = 1, self.pool.size do
       e = self.pool:get(i)

       local time = e:get(C.Time)

       love.graphics.origin()
       love.graphics.print(time.m, 0, 0)
       love.graphics.print(":", 16, 0)
       love.graphics.print(time.s, 24, 0) 
    end
 end

 return TimeSystem