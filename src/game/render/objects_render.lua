---@class ObjectsRender
ObjectsRender = {}

function ObjectsRender:create()

  local obj = {}

  -- Methods

  -- @param objects Object[]
  function obj:render(objects)
    local visibleTiles = BackgroundRender.visibleTiles
    local sx, sy = GameScene.SX, GameScene.SY
    
    for i = 1, #objects do
      local object = objects[i]

      local row = visibleTiles[object.worldY]

      if row and row[object.worldX] then
        love.graphics.draw(
          object.sprite,
          object.x, object.y,
          0,
          sx, sy
        )
      end
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end