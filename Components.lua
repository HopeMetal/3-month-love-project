local Component = require("libs.Concord.component")
local Components = {}

Components.Rect = Component(function(self, w, h) self.w = w self.h = h end)
Components.Position = Component(function(self, x, y) self.x = x self.y = y end)
Components.Velocity = Component(function(self, x, y, max) self.x = x or 0 self.y = y or 0 self.max = max or 100 end)
Components.Acceleration = Component(function(self, x, y) self.x = x self.y = y end)
Components.Friction = Component(function(self, v) self.v = v or 50 end)
Components.Gravity = Component(function(self, g) self.g = g or 10 end)
Components.Op = Component(function(self) self.a = "op" end)
Components.Ball = Component(function(self) self.a = "ball" end)

Components.BumpSensor = Component(function(self, x, y, w, h) self.name = "BumpSensor" self.x = x self.y = y self.w = w self.h = h self.on = false end)

local function playerInput(self, arate)
    self.arate = arate or 320
    self.pressedKeys = {}
    self.actions = {["z"] = 1, ["down"] = 1, ["left"] = 1, ["right"] = 1}
end
Components.PlayerInput = Component(playerInput)

function Components.PlayerInput.registerKey(self, key, state)
    if self.actions[key] then
        self.pressedKeys[key] = state
    end
end

Components.World = Component(function(self) end)

Components.Bounce = Component(function(self, b) self.b = b or 80 end)

Components.Score = Component(function(self, o) self.s = 0 self.o = o end)

return Components