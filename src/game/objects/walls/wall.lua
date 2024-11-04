Wall = {}

function Wall:create(worldX, worldY, px, py, scaleX, scaleY)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/stonewall.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    
    obj.worldX = worldX
    obj.worldY = worldY

    obj.w = obj.sprite:getWidth() * scaleX
    obj.h = obj.sprite:getHeight() * scaleY

    obj.x = obj.sprite:getWidth() * scaleX * worldX + px
    obj.y = obj.sprite:getHeight() * scaleY * worldY + py

    obj.directionX = 1

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end