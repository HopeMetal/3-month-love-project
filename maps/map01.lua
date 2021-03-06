return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 40,
  tilewidth = 24,
  tileheight = 24,
  nextlayerid = 2,
  nextobjectid = 7,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "objectgroup",
      id = 1,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 360,
          width = 312,
          height = 72,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 360,
          width = 216,
          height = 72,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 408,
          y = 288,
          width = 72,
          height = 72,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "exit",
          type = "",
          shape = "rectangle",
          x = 744,
          y = 312,
          width = 48,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {
            ["Exit"] = "map02"
          }
        },
        {
          id = 5,
          name = "playerSpawn",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 336,
          width = 24,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "mplat",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 216,
          width = 48,
          height = 24,
          rotation = 0,
          visible = true,
          properties = {
            ["xVelocity"] = 80,
            ["yVelocity"] = 0
          }
        }
      }
    }
  }
}
