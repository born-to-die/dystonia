ItemsRender = {}

function ItemsRender:create()
  
  local obj = {}

  -- @mapItems(table) Array with MapItem classes
  function obj:render(mapItems)
    
    for i = 1, #mapItems do
      love.graphics.draw(
        mapItems[i].sprite,
        mapItems[i].x,
        mapItems[i].y,
        0,
        GameScene.SX, GameScene.SY,
        mapItems[i].sprite:getWidth() / 2, mapItems[i].sprite:getHeight() / 2
      )

      if DEBUG_RENDER == true then
        love.graphics.setColor(1, 1, 0)
        love.graphics.circle("fill", mapItems[i].x, mapItems[i].y, 2)
        love.graphics.setColor(1, 1, 1)
      end
    end

    if DEBUG_RENDER then
      love.graphics.print("Items: " .. #mapItems, 0, 60)
    end

  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end