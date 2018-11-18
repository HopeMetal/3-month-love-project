local System = require("libs.Concord.system")
local Entity = require("libs.Concord.entity")
local C = require("Components")
local MapLoadSystem = System({})

  function MapLoadSystem:init(message)
    print(message)
 end
 
 function MapLoadSystem:entityAdded(e)
    print(tostring(e).." was added to the MapLoad System.")
 end
 
 function MapLoadSystem:LoadMap(mapname)
  local instance = self:getInstance()
  instance:clear()

  local World = Entity()
  World:give(C.World)
      :apply()
  instance:addEntity(World)

  self.mplatsToAdd = {}
  self.wallsToAdd = {}
  
  
  local map = love.filesystem.load("maps/"..mapname..".lua")()
  
  for objindex, object in pairs(map.layers[1].objects) do
    if object.name == "playerSpawn" then
      print("adding player spawn")
        self.playerSpawn = {}
        self.playerSpawn.x = object.x
        self.playerSpawn.y = object.y
    elseif object.name == "exit" then
      print("adding exit", object.x, object.y)
      self.exitSpawn = {}
      self.exitSpawn.x = object.x
      self.exitSpawn.y = object.y
      self.exitSpawn.w = object.width
      self.exitSpawn.h = object.height
      self.exitSpawn.dest = object.properties.Exit
    elseif object.name == "mplat" then
      self.mplatsToAdd[#self.mplatsToAdd + 1] = {x = object.x, y = object.y, w = object.width, h = object.height, yVel = object.properties.yVelocity or 0, xVel = object.properties.xVelocity or 0}
    else
      self.wallsToAdd[#self.wallsToAdd + 1] = {x = object.x, y = object.y, w = object.width, h = object.height}
    end
    print(objindex, object.name, object.x, object.y)
  end

  --add walls to world
  while #self.wallsToAdd > 0 do
    print("adding wall")
    ind = #self.wallsToAdd
     local wall = self.wallsToAdd[ind]
     local wallEntity = Entity()
     wallEntity:give(C.Position, wall.x, wall.y)
     :give(C.Rect, wall.w, wall.h)
     :apply()

     instance:addEntity(wallEntity)
     table.remove(self.wallsToAdd)
  end

  --add moving platforms to world
  while #self.mplatsToAdd > 0 do
    print("adding mplat")
    ind = #self.mplatsToAdd
    local wall = self.mplatsToAdd[ind]
    local wallEntity = Entity()
    wallEntity:give(C.Position, wall.x, wall.y)
    :give(C.Rect, wall.w, wall.h)
    :give(C.Velocity, wall.xVel, wall.yVel)
    :give(C.MPlat)
    :apply()
  
    instance:addEntity(wallEntity)
    table.remove(self.mplatsToAdd)
  end

  

  local Time = Entity()
  Time:give(C.Time)
  :apply()

  local Player = Entity()
  local playerSpawn = self.playerSpawn
  local exitSpawn = self.exitSpawn
  Player:give(C.Position, playerSpawn.x, playerSpawn.y)
        :give(C.Rect, 20, 80)
        :give(C.Velocity, 0, 0, 160)
        --:give(C.Friction, 640)
        :give(C.Acceleration, 0, 0)
        :give(C.Gravity, 1)
        :give(C.PlayerInput)
        :give(C.Camera)
        :apply()

  local Exit = Entity()
  Exit:give(C.Position, exitSpawn.x, exitSpawn.y)
      :give(C.Rect, exitSpawn.w, exitSpawn.h, true)
      :give(C.Exit, exitSpawn.dest)
      :apply()

      instance:addEntity(Time)
      instance:addEntity(Player)
      instance:addEntity(Exit)
 end

 return MapLoadSystem