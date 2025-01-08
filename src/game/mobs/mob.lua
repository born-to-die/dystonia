---@class Mob
---@field x number
---@field y number
---@field update fun()
---@field moveRandomly fun()
---@field behaviors Behavior[]
---@field speed number
---@field health number
---@field alive boolean
---@field foodSaturation number
---@field vector Vector
Mob = {}

---@param x number
---@param y number
function Mob:create(x, y)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")

    -- Position & Movement
    obj.worldX = 5
    obj.worldY = 5
    obj.x = x
    obj.y = y
    
    -- Attributes
    obj.behaviors = {}
    obj.alive = true
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

        if obj.health <= 0 then
            obj.alive = false
            return
        end

        for i = 1, #obj.behaviors, 1 do
            if obj.behaviors[i]:canExecute() then
                obj.behaviors[i]:execute(self)
            end
        end

        obj:foodSaturationUpdate()

        obj:specifyUpdate()
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
            if obj.foodSaturation <= 0 then
                obj.health = obj.health - 1
            else
                obj.foodSaturation = obj.foodSaturation - 1
            end

            self.foodSaturationIntervalTimer = TIMER(0.25, self.call)
            return true
        end
    end

    function obj:die()
        obj.sprite:setColor(0.5, 0.5, 0.5)
    end

    ---@param x number
    ---@param y number
    function obj:setPosition(x, y)
        obj.x = x
        obj.y = y
    end

    function obj:specifyUpdate()
        -- Special update for childs
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end