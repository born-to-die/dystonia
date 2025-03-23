---@class Raycast
Raycast = {}

function Raycast:create()

  local obj = {}
  
  setmetatable(obj, self)
  self.__index = self

  return obj
end

--- @param x1 number
--- @param y1 number
--- @param x2 number
--- @param y2 number
--- @param walls table
--- @return boolean
function Raycast:isVisible(x1, y1, x2, y2, walls)
  local dx, dy = x2 - x1, y2 - y1

  local steps = math.max(math.abs(dx), math.abs(dy))
  local stepX, stepY = dx / steps, dy / steps
 
  local px, py = x1, y1

  local isWall = false
  local nowInWall = false

  for i = 1, steps do

      px, py = px + stepX, py + stepY

      isWall = false

      for _, wall in ipairs(walls) do

          if CollisionChecker:isXYInRect(px, py, wall) then
              isWall = true
              nowInWall = true
              goto continue
          end
      end

      ::continue::

      if (isWall == false and nowInWall == true) then
        return false
      end
  end

  return true
end
