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
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end