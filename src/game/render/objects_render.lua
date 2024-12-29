---@class ObjectsRender
ObjectsRender = {}

function ObjectsRender:create()

  local obj = {}

  -- Methods

  -- @param objects Object[]
  function obj:render(objects)
    for i = 1, #objects do
      love.graphics.draw(
        objects[i].sprite,
        objects[i].x,
        objects[i].y,
        0,
        GameScene.SX, GameScene.SY
    )
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end