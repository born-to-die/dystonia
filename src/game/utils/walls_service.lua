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
    WallsService.tailMap[wall.worldX + 1][wall.worldY + 1] = 1
end

---@param wall Wall
---@param index integer
---@return nil
function WallsService:deleteWall(wall, index)
  table.remove(GameScene.walls, index)
  WallsService.tailMap[wall.worldX][wall.worldY] = 0
end
