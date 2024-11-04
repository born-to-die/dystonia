Player = {}

function Player:create(worldX, worldY, px, py, scaleX, scaleY)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/player.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    obj.x = obj.sprite:getWidth() * scaleX * worldX + px
    obj.y = obj.sprite:getHeight() * scaleY * worldY + py

    obj.vector = Vector:create()

    obj.worldX = worldX
    obj.worldY = worldY

    obj.directionX = 1

    -- Methods

    function obj:moveX()
        obj.worldX = obj.worldX + 1
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end