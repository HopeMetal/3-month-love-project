local Component = require("libs.Concord.component")
local Components = {}

Components.Rect = Component(function(self, w, h, s)
    self.w = w self.h = h self.isSensor = s or false
    if s then
        self.on = false
    end
 end)
Components.Position = Component(function(self, x, y) self.x = x self.y = y end)
Components.Velocity = Component(function(self, x, y, max) self.x = x or 0 self.y = y or 0 self.max = max or 300 end)
Components.Acceleration = Component(function(self, x, y) self.x = x self.y = y self.energyX = 0 self.energyY = 0 end)
Components.Friction = Component(function(self, v) self.v = v or 50 end)
Components.Gravity = Component(function(self, g) self.g = g or 1 end)
Components.Op = Component(function(self) self.a = "op" end)
Components.Ball = Component(function(self) self.a = "ball" end)

Components.BumpSensor = Component(function(self, x, y, w, h) self.name = "BumpSensor" self.x = x self.y = y self.w = w self.h = h self.on = false end)

local function playerInput(self, arate)
    self.arate = arate or 640
    self.pressedKeys = {}
    self.actions = {["z"] = 1, ["down"] = 1, ["left"] = 1, ["right"] = 1}
    self.onGround = false
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

Components.Camera = Component(function(self) end)

Components.Time = Component(function(self) self.m = 0 self.s = 0 self.dtpassed = 0 self.active = true end)

Components.Exit = Component(function(self, dest) self.destination = dest end)

Components.MPlat = Component(function(self) end)

return Components