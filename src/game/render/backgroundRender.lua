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
        obj.playerTileX = playerX
        obj.playerTileY = playerY
        obj:updateAllVisibility()
    end

    for y = 0, 9, 1 do
        for x = 0, 9, 1 do

            love.graphics.setColor(0.5, 0.5, 0.5)

            if
              BackgroundRender.visibleTiles[y] == nil
              or BackgroundRender.visibleTiles[y][x] == nil
              or BackgroundRender.visibleTiles[y][x] == false
            then
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

  function obj:updateAllVisibility()

    BackgroundRender.visibleTiles = {}

    for _, dir in ipairs(GameScene.FOV_DEFAULT_RAY_DIRECTIONS) do

        local px, py = GameScene.player.worldX, GameScene.player.worldY

        for i = 1, GameScene.FOV_DEFAULT_RADIUS do
            px = px + dir.dx * 0.5
            py = py + dir.dy * 0.5

            local tx = math.floor(px)
            local ty = math.floor(py)

            BackgroundRender.visibleTiles[ty] = BackgroundRender.visibleTiles[ty] or {}
            BackgroundRender.visibleTiles[ty][tx] = true

            love.graphics.circle("fill", ty * 64 + GameScene.PX, ty * 64 + GameScene.PY, 2)

            if GameScene.wallsService:isWall(tx, ty) then
                goto nextRay
            end
        end

        ::nextRay::
    end
  end

  obj:updateAllVisibility()

  setmetatable(obj, self)
  self.__index = self

  return obj
end
