WallRender = {}

function WallRender:create()
  
  local obj = {}

  ---@param walls Wall[]
  function obj:render(walls, sx, sy)
    local visibleTiles = BackgroundRender.visibleTiles
    local px, py = GameScene.PX, GameScene.PY
    local tileSizeX, tileSizeY = GFX_TILE_SCALE_X, GFX_TILE_SCALE_Y
    local tilePx = GFX_TILE_SIZE_PX
    local debugRender = DEBUG_RENDER

    for i = 1, #walls do
      local wall = walls[i]

      local row = visibleTiles[wall.worldY]

      if row and row[wall.worldX] then
        love.graphics.draw(wall.sprite, wall.x, wall.y, 0, sx, sy)

        if debugRender then
          love.graphics.rectangle("line", wall.x, wall.y, tilePx, tilePx)
          love.graphics.print("health: " .. wall.health, wall.x, wall.y)
          love.graphics.print("Walls: " .. #walls, 0, 45)
          love.graphics.print("Mobs: " .. #GameScene.mobs, 0, 75)
        end
      end
    end
  end

  setmetatable(obj, self)
    self.__index = self

    return obj
end
