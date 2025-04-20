ItemsRender = {}

function ItemsRender:create()
  
  local obj = {}

  ---@param mapItems MapItem[]
  function obj:render(mapItems)
    local visibleTiles = BackgroundRender.visibleTiles
    local sx, sy = GameScene.SX, GameScene.SY
    local debugRender = DEBUG_RENDER
    
    for i = 1, #mapItems do
      local item = mapItems[i]
      local sw, sh = item.sprite:getWidth() / 2, item.sprite:getHeight() / 2

      local row = visibleTiles[item.worldY]

      if row and row[item.worldX] then
        love.graphics.draw(
          item.sprite,
          item.x, item.y,
          0,
          sx, sy,
          item.sprite:getWidth() / 2, item.sprite:getHeight() / 2
        )

        if debugRender then
          love.graphics.setColor(1, 1, 0)
          love.graphics.circle("fill", item.x, item.y, 2)
          love.graphics.setColor(1, 1, 1)
        end
      end
    end

    if debugRender then
      love.graphics.print("Items: " .. #mapItems, 0, 60)
    end

  end

  setmetatable(obj, self)
  self.__index = self

  return obj
end