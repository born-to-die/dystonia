---@class Mob
---@field x number
---@field y number
Mob = {}

---@param worldX number
---@param worldY number
function Mob:create(worldX, worldY)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")

    -- Position & Movement
    obj.worldX = worldX
    obj.worldY = worldY
    obj.x = worldX * GFX_TILE_SIZE_PX * GameScene.SX + GameScene.PX + 32
    obj.y = worldY * GFX_TILE_SIZE_PX * GameScene.SY + GameScene.PY + 32
    obj.vector = Vector:create()

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end