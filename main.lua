local Concord = require("libs.Concord").init({
    useEvents = true,
  })
  
  -- Create a new Instance to work with
  local Instance = require("libs.Concord.instance")
  local myInstance = Instance()

  local C = require("Components")
  local Entity = require("libs.Concord.entity")

  local myEntity = Entity()
  myEntity:give(C.Position, 90, 260)
  :give(C.Rect, 20, 80)
  :give(C.Velocity, 0, 0, 160)
  :give(C.Friction, 160)
  :give(C.Acceleration, 0, 0)
  :give(C.Gravity, 50)
  :give(C.PlayerInput)
  :give(C.BumpSensor, -5, 80, 30, 5)
  :apply()

  local paddletwo = Entity()
  paddletwo:give(C.Position, 710, 260)
  :give(C.Rect, 20, 80)
  :give(C.Velocity, 0, 80, 160)
  --:give(C.Friction, 80)
  :give(C.Acceleration, 0, 0)
  :apply()

  local ball = Entity()
  ball:give(C.Position, 120, 290)
      :give(C.Rect, 10, 10)
      :give(C.Velocity, 100, 0, 160)
      :give(C.Acceleration, 0, 0)
      :give(C.Gravity, 50)
      :give(C.Bounce, 300)
      :apply()

  local floor = Entity()
  floor:give(C.Position, 0, 580)
       :give(C.Rect, 800, 20)
       :apply()

  local World = Entity()
  World:give(C.World)
       :apply()

  local YourScore = Entity()
  YourScore:give(C.Position, 0, 0)
           :give(C.Score, 0)
           :apply()

  local OpScore = Entity()
  OpScore:give(C.Position, 100, 0)
         :give(C.Score, 1)
         :apply()

  -- Add the Instance to concord to make it active
  Concord.addInstance(myInstance)
  
  local RectDrawSystemClass = require("RectDrawSystem")
  local RectUpdateSystemClass = require("RectUpdateSystem")
  local OpUpdateSystemClass = require("OpUpdateSystem")
  local GravitySystemClass = require("GravitySystem")
  local KeyPressedSystemClass = require("KeyPressedSystem")
  local FrictionSystemClass = require("FrictionSystem")
  local VelocitySystemClass = require("VelocitySystem")
  local AccelSystemClass = require("AccelSystem")
  local BumpSystemClass = require("BumpSystem")
  local BounceSystemClass = require("BounceSystem")
  local ScoreSystemClass = require("ScoreSystem")

 local RectDrawSystem = RectDrawSystemClass("Hi")
 local RectUpdateSystem = RectUpdateSystemClass("Hi Two.")
 local KeyPressedSystem = KeyPressedSystemClass("Hi keys")
 local OpUpdateSystem = OpUpdateSystemClass("Hi op")
 local GravitySystem = GravitySystemClass("Hi gravity")
 local FrictionSystem = FrictionSystemClass("Hi friction")
  local VelocitySystem = VelocitySystemClass("Hi velocity")
  local AccelSystem = AccelSystemClass("Hi accel")
  local BumpSystem = BumpSystemClass("Hi bump")
  local BounceSystem = BounceSystemClass("Hi bounce")
  local ScoreSystem = ScoreSystemClass("Hi score")

myInstance:addSystem(BumpSystem, "update")
myInstance:addSystem(RectDrawSystem, "draw")
myInstance:addSystem(BumpSystem, "draw")
myInstance:addSystem(RectUpdateSystem, "update")
myInstance:addSystem(KeyPressedSystem, "keypressed")
myInstance:addSystem(KeyPressedSystem, "keyreleased")
myInstance:addSystem(OpUpdateSystem, "update")
myInstance:addSystem(FrictionSystem, "update")
--myInstance:addSystem(VelocitySystem, "update")
myInstance:addSystem(GravitySystem, "update")
myInstance:addSystem(AccelSystem, "update")
myInstance:addSystem(ScoreSystem, "update")
myInstance:addSystem(ScoreSystem, "draw")
--myInstance:addSystem(BounceSystem, "update")


myInstance:addEntity(myEntity)
--myInstance:addEntity(ball)
myInstance:addEntity(paddletwo)
myInstance:addEntity(floor)
myInstance:addEntity(World)
myInstance:addEntity(YourScore)
myInstance:addEntity(OpScore)

  -- We can also remove it again
  --Concord.removeInstance(myInstance)