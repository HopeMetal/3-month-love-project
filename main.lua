local Concord = require("libs.Concord").init({
    useEvents = true,
  })
  
  -- Create a new Instance to work with
  local Instance = require("libs.Concord.instance")
  local myInstance = Instance()

  local C = require("Components")
  local Entity = require("libs.Concord.entity")

  local map = require("maps.map01")

  --[[for i, v in pairs(map) do
    print(i, v)
  end

  print("map layers:")
  for i, v in pairs(map.layers) do
    print(i, v)
    if type(v) == "table" then
        for j, u in pairs(v) then
            print()
        end
    end
  end]]



  -- Add the Instance to concord to make it active
  Concord.addInstance(myInstance)
  
  local RectDrawSystemClass = require("RectDrawSystem")
  local PlayerUpdateSystemClass = require("PlayerUpdateSystem")
  local OpUpdateSystemClass = require("OpUpdateSystem")
  local GravitySystemClass = require("GravitySystem")
  local KeyPressedSystemClass = require("KeyPressedSystem")
  local FrictionSystemClass = require("FrictionSystem")
  local VelocitySystemClass = require("VelocitySystem")
  local AccelSystemClass = require("AccelSystem")
  local BumpSystemClass = require("BumpSystem")
  local BounceSystemClass = require("BounceSystem")
  local ScoreSystemClass = require("ScoreSystem")
  local CameraSystemClass = require("CameraSystem")
  local TimeSystemClass = require("TimeSystem")
  local ExitSystemClass = require("ExitSystem")

 local RectDrawSystem = RectDrawSystemClass("Hi")
 local PlayerUpdateSystem = PlayerUpdateSystemClass("Hi player")
 local KeyPressedSystem = KeyPressedSystemClass("Hi keys")
 local OpUpdateSystem = OpUpdateSystemClass("Hi op")
 local GravitySystem = GravitySystemClass("Hi gravity")
 local FrictionSystem = FrictionSystemClass("Hi friction")
 local VelocitySystem = VelocitySystemClass("Hi velocity")
 local AccelSystem = AccelSystemClass("Hi accel")
 local BumpSystem = BumpSystemClass("Hi bump")
 local BounceSystem = BounceSystemClass("Hi bounce")
 local ScoreSystem = ScoreSystemClass("Hi score")
 local CameraSystem = CameraSystemClass("Hi camera")
 local TimeSystem = TimeSystemClass("Hi time")
 local ExitSystem = ExitSystemClass("Hi exit")

myInstance:addSystem(KeyPressedSystem, "keypressed")
myInstance:addSystem(KeyPressedSystem, "keyreleased")

myInstance:addSystem(BumpSystem, "update")
myInstance:addSystem(PlayerUpdateSystem, "update")
myInstance:addSystem(OpUpdateSystem, "update")
myInstance:addSystem(FrictionSystem, "update")
myInstance:addSystem(GravitySystem, "update")
myInstance:addSystem(AccelSystem, "update")
myInstance:addSystem(ExitSystem, "update")
myInstance:addSystem(TimeSystem, "update")

--myInstance:addSystem(CameraSystem, "draw")
myInstance:addSystem(RectDrawSystem, "draw")
myInstance:addSystem(BumpSystem, "draw")
myInstance:addSystem(TimeSystem, "draw")
myInstance:addSystem(FrictionSystem, "draw")
--myInstance:addSystem(BounceSystem, "update")

local playerSpawn
local exitSpawn

local wallsToAdd = {}
local mplatsToAdd = {}

for objindex, object in pairs(map.layers[1].objects) do
  if object.name == "playerSpawn" then
      playerSpawn = {}
      playerSpawn.x = object.x
      playerSpawn.y = object.y
  elseif object.name == "exit" then
    exitSpawn = {}
    exitSpawn.x = object.x
    exitSpawn.y = object.y
    exitSpawn.w = object.width
    exitSpawn.h = object.height
  elseif object.name == "mplat" then
    mplatsToAdd[#mplatsToAdd + 1] = {x = object.x, y = object.y, w = object.width, h = object.height, yVel = object.properties.yVelocity}
  else
    wallsToAdd[#wallsToAdd + 1] = {x = object.x, y = object.y, w = object.width, h = object.height}
  end

  print(objindex, object.name, object.x, object.y)
end
--print(map.layers[1].objects[1].x, map.layers[1].objects[1].y)

local Player = Entity()
Player:give(C.Position, playerSpawn.x, playerSpawn.y)
:give(C.Rect, 20, 80)
:give(C.Velocity, 0, 0, 160)
:give(C.Friction, 640)
:give(C.Acceleration, 0, 0)
:give(C.Gravity, 1)
:give(C.PlayerInput)
:give(C.Camera)
:apply()

local Exit = Entity()
Exit:give(C.Position, exitSpawn.x, exitSpawn.y)
    :give(C.Rect, exitSpawn.w, exitSpawn.h, true)
    :give(C.Exit)
    :apply()

--[[local Exit2 = Entity()
Exit2:give(C.Position, -1150, 500)
     :give(C.BumpSensor, 0, 0, 50, 50)
     :give(C.Exit)
     :apply()]]

--[[local paddletwo = Entity()
paddletwo:give(C.Position, 710, 260)
:give(C.Rect, 20, 80)
:give(C.Velocity, 0, 80, 160)
--:give(C.Friction, 80)
:give(C.Acceleration, 0, 0)
:apply()]]

--[[local ball = Entity()
ball:give(C.Position, 120, 290)
    :give(C.Rect, 10, 10)
    :give(C.Velocity, 100, 0, 160)
    :give(C.Acceleration, 0, 0)
    :give(C.Gravity, 50)
    :give(C.Bounce, 300)
    :apply()]]

--[[local floor = Entity()
floor:give(C.Position, -400, 580)
     :give(C.Rect, 1600, 20)
     :apply()]]

local World = Entity()
World:give(C.World)
     :apply()

--[[local YourScore = Entity()
YourScore:give(C.Position, 0, 0)
         :give(C.Score, 0)
         :apply()

local OpScore = Entity()
OpScore:give(C.Position, 100, 0)
       :give(C.Score, 1)
       :apply()
]]

local Time = Entity()
Time:give(C.Time)
:apply()

while #wallsToAdd > 0 do
    ind = #wallsToAdd
     local wall = wallsToAdd[ind]
     local wallEntity = Entity()
     wallEntity:give(C.Position, wall.x, wall.y)
     :give(C.Rect, wall.w, wall.h)
     :apply()

     myInstance:addEntity(wallEntity)
     table.remove(wallsToAdd)
end

while #mplatsToAdd > 0 do
  ind = #mplatsToAdd
   local wall = mplatsToAdd[ind]
   local wallEntity = Entity()
   wallEntity:give(C.Position, wall.x, wall.y)
   :give(C.Rect, wall.w, wall.h)
   :give(C.Velocity, 0, wall.yVel)
   :give(C.MPlat)
   :apply()

   myInstance:addEntity(wallEntity)
   table.remove(mplatsToAdd)
end


myInstance:addEntity(Player)
--myInstance:addEntity(ball)
--myInstance:addEntity(paddletwo)
--myInstance:addEntity(floor)
myInstance:addEntity(World)
--myInstance:addEntity(YourScore)
--myInstance:addEntity(OpScore)
myInstance:addEntity(Time)
myInstance:addEntity(Exit)

  -- We can also remove it again
  --Concord.removeInstance(myInstance)