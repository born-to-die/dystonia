---@class Player
---@field worldX number
---@field worldY number
---@field x number
---@field y number
---@field foodSaturation number
Player = {}

function Player:create(worldX, worldY, px, py, scaleX, scaleY)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/player.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Position & Movement
    obj.worldX = worldX
    obj.worldY = worldY
    obj.x = obj.sprite:getWidth() * scaleX * worldX + px
    obj.y = obj.sprite:getHeight() * scaleY * worldY + py
    obj.vector = Vector:create()
    obj.directionX = 1

    -- Needle
    obj.foodSaturation = 100

    -- Methods

    function obj:moveX()
        obj.worldX = obj.worldX + 1
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end