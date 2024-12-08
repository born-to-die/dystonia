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
    obj.vector = Vector:create()
    
    -- Attributes
    obj.behaviors = {}
    obj.speed = 10
    obj.health = 40
    obj.foodSaturation = 100

    -- Methods

    function obj:update()
        for i = 1, #obj.behaviors, 1 do
            if obj.behaviors[i]:canExecute() then
                obj.behaviors[i]:execute(self)
            end
        end
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

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end