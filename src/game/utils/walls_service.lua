---@class WallsService
WallsService = {}

WallsService.tailMap = {
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0},
    {0,0,0,0,0,0,0,0,0,0}
  }

---@return WallsService
function WallsService:create()

  local obj = {}
  
  setmetatable(obj, self)
  self.__index = self

  return obj
end


---@param wall Wall
---@return nil
function WallsService:addWall(wall)
    table.insert(GameScene.walls, wall)
    WallsService.tailMap[wall.worldY + 1][wall.worldX + 1] = 1
end

---@param wall Wall
---@param index integer
---@return nil
function WallsService:deleteWall(wall, index)
    table.remove(GameScene.walls, index)
    WallsService.tailMap[wall.worldY + 1][wall.worldX + 1] = 0
end

---@param x integer
---@param y integer
---@return boolean
function WallsService:isWall(x, y)
    return WallsService.tailMap[y + 1] and WallsService.tailMap[y + 1][x + 1] == 1
end
