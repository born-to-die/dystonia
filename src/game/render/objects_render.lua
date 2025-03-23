---@class ObjectsRender
ObjectsRender = {}

function ObjectsRender:create()

  local obj = {}

  -- Methods

  -- @param objects Object[]
  function obj:render(objects)

    for _, object in pairs(objects) do

      local objectTileX = math.floor((object.x - GameScene.PX) / GFX_TILE_SCALE_X)
      local objectTileY = math.floor((object.y - GameScene.PY) / GFX_TILE_SCALE_Y)

      if
        BackgroundRender.visibleTiles == nil 
        or BackgroundRender.visibleTiles[objectTileY] == nil
        then
        goto continue
      end

      if (BackgroundRender.visibleTiles[objectTileY][objectTileX] == false) then
        goto continue
      end

      love.graphics.draw(
        object.sprite,
        object.x,
        object.y,
        0,
        GameScene.SX, GameScene.SY
    )

    ::continue::
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end