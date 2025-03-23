WallRender = {}

function WallRender:create()
  
  local obj = {}

  -- @param walls table Array with Wall classes
  -- @param sx float Scale X
  -- @param sy float Scale Y
  function obj:render(walls, sx, sy)
    
    for i = 1, #walls do
      
      local wallTileX = math.floor((walls[i].x - GameScene.PX) / GFX_TILE_SCALE_X)
      local wallTileY = math.floor((walls[i].y - GameScene.PY) / GFX_TILE_SCALE_Y)

      if
        BackgroundRender.visibleTiles == nil 
        or BackgroundRender.visibleTiles[wallTileY] == nil
        then
        goto continue
      end

      local isVisible = BackgroundRender.visibleTiles[wallTileY][wallTileX]

      if (isVisible == false) then
        goto continue
      end

      love.graphics.draw(
        walls[i].sprite,
        walls[i].x,
        walls[i].y,
        0,
        sx, sy
      )

      if DEBUG_RENDER then
        love.graphics.rectangle("line", walls[i].x, walls[i].y, GFX_TILE_SIZE_PX, GFX_TILE_SIZE_PX)
        love.graphics.print("health: " .. walls[i].health, walls[i].x, walls[i].y)
      end

        ::continue::
    end

    if DEBUG_RENDER then
      love.graphics.print("Walls: " .. #walls, 0, 45)
    end

  end

  setmetatable(obj, self)
    self.__index = self

    return obj
end
