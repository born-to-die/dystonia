SpawnModeService = {}

SpawnModeService.mouseWallX = 1
SpawnModeService.mouseWallY = 1

SpawnModeService.spawnObjects = {
  love.graphics.newImage("gfx/slime_mob.png"),
  love.graphics.newImage("gfx/red_slime_mob.png"),
  love.graphics.newImage("gfx/hound_mob.png"),
  love.graphics.newImage("gfx/blue_mushrooms_object.png"),
}
SpawnModeService.spawnObjectsIndex = 1

SpawnModeService.spawnObjectsFuncs = {
  function(x, y) table.insert(GameScene.mobs, SlimeMob:create(x, y)) end,
  function(x, y) table.insert(GameScene.mobs, RedSlimeMob:create(x, y)) end,
  function(x, y) table.insert(GameScene.mobs, HoundMob:create(x, y)) end,
}

---@public
---@param x integer
---@param y integer
function SpawnModeService:spawn(x, y)
  if GameScene.SPAWN_MODE and SpawnModeService:isCursorOnTile() then
    SpawnModeService.spawnObjectsFuncs[SpawnModeService.spawnObjectsIndex](x, y)
  end
end

---@public
---@param forward boolean
function SpawnModeService:moveIndex(forward)
  if forward then
    if self.spawnObjectsIndex < #self.spawnObjects then
      self.spawnObjectsIndex = self.spawnObjectsIndex + 1
    else
      self.spawnObjectsIndex = 1
    end
  else
    if self.spawnObjectsIndex > 1 then
      self.spawnObjectsIndex = self.spawnObjectsIndex - 1
    else
      self.spawnObjectsIndex = #self.spawnObjects
    end
  end
end

---@public
---@return boolean
function SpawnModeService:isCursorOnTile()
  local mouseX, mouseY = love.mouse.getPosition()
  local wx = math.floor((mouseX - GameScene.PX) / GFX_TILE_SCALE_X)
  local wy = math.floor((mouseY - GameScene.PY) / GFX_TILE_SCALE_Y)

  if (wx < 0 or wx > GameScene.MAP_TILES_X) then
    return false
  end

  if (wy < 0 or wy > GameScene.MAP_TILES_Y) then
    return false
  end

  SpawnModeService.mouseWallX = wx
  SpawnModeService.mouseWallY = wy

  return true
end
