BackgroundRender = {}

function BackgroundRender:create()
  
  local obj = {}
  
  obj.stoneFloorImage = love.graphics.newImage("gfx/stonefloor.png")
  obj.stoneFloorImage:setFilter(GFX_DEFAULT_IMAGE_FILTER)
  
  -- player is Player
  -- px, py is offsets
  -- scaleX, scaleY is scale of window
  function obj:render(player, px, py, scaleX, scaleY)
    
    for y = 0, 9, 1 do
        for x = 0, 9, 1 do
            local px = x * GFX_TILE_SIZE_PX * scaleX + px
            local py = y * GFX_TILE_SIZE_PX * scaleY + py

            love.graphics.draw(self.stoneFloorImage,
                px, py,
                0,
                scaleX, scaleY
            )

            if DEBUG_RENDER == true then
              love.graphics.print(x .. ":" .. y, px, py)
            end
        end
    end;
    
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end