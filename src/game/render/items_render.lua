ItemsRender = {}

function ItemsRender:create()
  
  local obj = {}

  -- @mapItems(table) Array with MapItem classes
  function obj:render(mapItems)
    
    for i = 1, #mapItems do
      love.graphics.draw(
        mapItems[i].sprite,
        mapItems[i].worldY * GameScene.SX + GameScene.PX,
        mapItems[i].worldY * GameScene.SY + GameScene.PY,
        0,
        GameScene.SX, GameScene.SY
    )
    end

    if DEBUG_RENDER then
      love.graphics.print("Items: " .. #mapItems, 0, 60)
    end

  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end