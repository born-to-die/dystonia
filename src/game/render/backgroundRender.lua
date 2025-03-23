BackgroundRender = {}

BackgroundRender.visibleTiles = {}

function BackgroundRender:create()

  local obj = {}
  obj.frameCounter = 0
  obj.updateRow = 0
  obj.totalRows = 10
  obj.playerTileX = 0
  obj.playerTileY = 0
  obj.isVisibilityProgress = true

  obj.stoneFloorImage = love.graphics.newImage("gfx/stonefloor.png")
  obj.stoneFloorImage:setFilter(GFX_DEFAULT_IMAGE_FILTER)

  obj.raycastCosinuses = {}
  obj.raycastSinuses = {}

  -- player is Player
  -- px, py is offsets
  -- scaleX, scaleY is scale of window
  function obj:render(player, px, py, scaleX, scaleY)

    local playerX = GameScene.player.worldX
    local playerY = GameScene.player.worldY

    if obj.playerTileX ~= playerX or obj.playerTileY ~= playerY then
        obj.isVisibilityProgress = true
        obj.updateRow = 0
        obj.playerTileX = playerX
        obj.playerTileY = playerY
    end

    if obj.isVisibilityProgress then
      obj:updateVisibilityStep()
    end

    for y = 0, 9, 1 do
        for x = 0, 9, 1 do

            love.graphics.setColor(0.5, 0.5, 0.5)

            if BackgroundRender.visibleTiles[y][x] == false then
              goto continue
            end

            local px = x * GFX_TILE_SCALE_X + GameScene.PX
            local py = y * GFX_TILE_SCALE_Y + GameScene.PY

            for _, object in pairs(GameScene.objects) do

              if object.name ~= "beacon" then
                goto continue3
              end

              local d = MathService:distance({x = px, y = py}, object)
              if d < 100 then
                love.graphics.setColor(1, 1, 1)
                goto continue2
              end

              ::continue3::
            end

            ::continue2::

            love.graphics.draw(self.stoneFloorImage,
                px, py,
                0,
                scaleX, scaleY
            )

            if DEBUG_RENDER == true then
              love.graphics.print(x .. ":" .. y, px, py)
            end

            ::continue::
        end
    end

    love.graphics.setColor(1, 1, 1)
  end

  function obj:updateVisibilityStep()
    if obj.updateRow >= obj.totalRows then
      obj.isVisibilityProgress = false
      return
    end

    for x = 0, 9 do
        local px = x * GFX_TILE_SCALE_X + GameScene.PX_WITH_HALF_SIZE_TILE_X
        local py = obj.updateRow * GFX_TILE_SCALE_Y + GameScene.PX_WITH_HALF_SIZE_TILE_Y

        BackgroundRender.visibleTiles[obj.updateRow] = BackgroundRender.visibleTiles[obj.updateRow] or {}
        
        BackgroundRender.visibleTiles[obj.updateRow][x] = Raycast:isVisible(GameScene.player.x, GameScene.player.y, px, py, GameScene.walls)
    end

    obj.updateRow = obj.updateRow + 1
  end

  function obj:updateAllVisibility()
    BackgroundRender.visibleTiles = {}

    for y = 0, 9 do
      BackgroundRender.visibleTiles[y] = {}

      for x = 0, 9 do
        local px = x * GFX_TILE_SCALE_X + GameScene.PX
        local py = y * GFX_TILE_SCALE_Y + GameScene.PY

        BackgroundRender.visibleTiles[y][x] = Raycast:isVisible(GameScene.player.x, GameScene.player.y, px, py, GameScene.walls)
      end
    end
  end

  obj:updateAllVisibility()

  setmetatable(obj, self)
  self.__index = self

  return obj
end
