---@class Mob
---@field x number
---@field y number
---@field update fun()
---@field moveRandomly fun()
---@field behaviors Behavior[]
---@field speed number
---@field health number
---@field foodSaturation number
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
    
    -- Attributes
    obj.behaviors = {}
    obj.speed = 100
    obj.health = 40
    obj.foodSaturation = 100

    obj.vector = Vector:create(0, 0, obj.speed)

    -- Methods

    obj.call = function ()
        obj:foodSaturationUpdate()
    end

    obj.foodSaturationIntervalTimer = TIMER(0.25, obj.call)

    function obj:update()
        for i = 1, #obj.behaviors, 1 do
            if obj.behaviors[i]:canExecute() then
                obj.behaviors[i]:execute(self)
            end
        end

        obj:foodSaturationUpdate()
    end

    function obj:moveRandomly()
        local rxv = math.random()
        local rxs = math.random(2)
        local ryv = math.random()
        local rys = math.random(2)

        if rxs == 1 then
            rxv = -rxv
        end

        if rys == 1 then
            ryv = -ryv
        end

        obj.vector:set(rxv, ryv, obj.speed);
    end

    function obj:foodSaturationUpdate()
        if not self.foodSaturationIntervalTimer.isExpired() then
            self.foodSaturationIntervalTimer.update(GameScene.DT)
            return false
        else
            obj.foodSaturation = obj.foodSaturation - 1
            self.foodSaturationIntervalTimer = TIMER(0.25, self.call)
            return true
        end
    end

    function obj:die()
        obj.sprite:setColor(0.5, 0.5, 0.5)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end