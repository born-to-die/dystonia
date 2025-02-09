WallRender = {}

function WallRender:create()
  
  local obj = {}

  -- @param walls table Array with Wall classes
  -- @param sx float Scale X
  -- @param sy float Scale Y
  function obj:render(walls, sx, sy)
    
    for i = 1, #walls do
      love.graphics.draw(
        walls[i].sprite,
        walls[i].x,
        walls[i].y,
        0, 
        sx, sy
      )

      if DEBUG_RENDER then
        love.graphics.circle("fill", walls[i].x, walls[i].y, 2)
      end
    end

    if DEBUG_RENDER then
      love.graphics.print("Walls: " .. #walls, 0, 45)
    end

  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end