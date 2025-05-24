SpawnModeRender = {}

---@public
function SpawnModeRender:render()
  if SpawnModeService:isCursorOnTile() then
        SpawnModeRender:cursorRender()
      end
end

---@private
function SpawnModeRender:cursorRender()
  local mouseX, mouseY = love.mouse.getPosition()

  love.graphics.setColor(1, 0.7, 0.5, 0.5)

  love.graphics.draw(
    SpawnModeService.spawnObjects[SpawnModeService.spawnObjectsIndex],
    mouseX,
    mouseY,
    0,
    GameScene.SX, GameScene.SY
  )

  love.graphics.rectangle(
    "line",
    SpawnModeService.mouseWallX * GFX_TILE_SIZE_PX + GameScene.PX,
    SpawnModeService.mouseWallY * GFX_TILE_SIZE_PX + GameScene.PY,
    GFX_TILE_SIZE_PX, GFX_TILE_SIZE_PX
  )

  love.graphics.setColor(1, 1, 1, 1)
end