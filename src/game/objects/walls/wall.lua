---@class Wall
---@field worldX number
---@field worldY number
---@field health number
Wall = {}

function Wall:create(worldX, worldY, px, py, scaleX, scaleY)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/stonewall.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    
    obj.worldX = worldX
    obj.worldY = worldY
    obj.health = 100

    obj.w = obj.sprite:getWidth() * scaleX
    obj.h = obj.sprite:getHeight() * scaleY

    obj.x = obj.sprite:getWidth() * scaleX * worldX + px
    obj.y = obj.sprite:getHeight() * scaleY * worldY + py

    obj.pointX = obj.sprite:getWidth() * scaleX * worldX + px + GFX_TILE_HALF_SIZE_PX
    obj.pointY = obj.sprite:getHeight() * scaleY * worldY + py + GFX_TILE_HALF_SIZE_PX

    obj.directionX = 1

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end

---@param damage number
---@return nil
function Wall:addDamage(damage)
    self.health = self.health - damage
end