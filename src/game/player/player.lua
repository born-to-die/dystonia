---@class Player
---@field worldX number
---@field worldY number
---@field x number
---@field y number
---@field speed number
---@field directionX number
---@field foodSaturation number
---@field vector Vector
---@field attackCooldown number
---@field currentAttackCooldown number
---@field attackFrameTime number
---@field currentAttackFrameTime number
---@field damage number
---@field inAttack boolean
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
    obj.speed = 150
    obj.vector = Vector:create(0, 0, 0)
    obj.directionX = 1

    -- Attacks properties
    obj.damage = 10
    obj.inAttack = false
    obj.attackCooldown = 0.5
    obj.currentAttackCooldown = 0
    obj.attackFrameTime = 0.1
    obj.currentAttackFrameTime = 0

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

function Player:getAttackHitbox()
    local mx, my = love.mouse.getPosition()

    local hitbox = {}

    hitbox.angle = math.atan2(my - self.y, mx - self.x)
    hitbox.radius = 30
    hitbox.x = self.x + math.cos(hitbox.angle) * hitbox.radius
    hitbox.y = self.y + math.sin(hitbox.angle) * hitbox.radius

    return hitbox
end