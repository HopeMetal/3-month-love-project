local System = require("libs.Concord.system")
local C = require("Components")
local ScoreSystem = System({C.Position, C.Score}, {C.Position, C.Bounce, "ball"})

  function ScoreSystem:init(message)
    print(message)
 end
 
 function ScoreSystem:entityAdded(e)
    print(tostring(e).." was added to the score System.")
 end
 
 function ScoreSystem:update(dt)
    local e
    for i = 1, self.ball.size do
       e = self.ball:get(i)
       
       --local s = e:get(C.Score)
       local rect = e:get(C.Rect)
       local p = e:get(C.Position)
       local win
       if p.x > 800 then
        win = 0
       elseif p.x < -rect.w then
        win = 1
       end

       for j = 1, self.pool.size do
        local score = self.pool:get(j):get(C.Score)
        if score.o == win then
          score.s = score.s + 1
          self:getInstance():removeEntity(e)
        end
      end
    end 
    -- Alternatively:
    -- for _, e in ipairs(self.pool.objects) do
 end

 function ScoreSystem:draw(dt)
  local e
  for i = 1, self.pool.size do
     e = self.pool:get(i)
     
     love.graphics.origin()
     local p = e:get(C.Position)
     local s = e:get(C.Score)
     love.graphics.print(s.s, p.x, p.y)
  end 
  -- Alternatively:
  -- for _, e in ipairs(self.pool.objects) do
end

 return ScoreSystem