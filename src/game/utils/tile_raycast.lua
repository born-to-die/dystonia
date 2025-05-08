---@class TileRaycast by Bresenham's line algorithm
TileRaycast = {}


function TileRaycast:isVisible(x0, y0, x1, y1)
  local dx = math.abs(x1 - x0)
  local dy = math.abs(y1 - y0)
  local sx = x0 < x1 and 1 or -1
  local sy = y0 < y1 and 1 or -1

  local err = dx - dy

  local tileMap = GameScene.wallsService.tailMap;

  while true do
    if tileMap[y0 + 1] == nil or tileMap[y0 + 1][x0 + 1] ~= 0 then
        return false
    end

    if x0 == x1 and y0 == y1 then break end

    local e2 = 2 * err
    if e2 > -dy then
        err = err - dy
        x0 = x0 + sx
    end
    if e2 < dx then
        err = err + dx
        y0 = y0 + sy
    end
  end

  return true
end
