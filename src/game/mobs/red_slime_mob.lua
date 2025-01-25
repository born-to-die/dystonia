---@class RedSlimeMob : SlimeMob
RedSlimeMob = {}

---@param x number
---@param y number
function RedSlimeMob:create(x, y)

    local obj = SlimeMob:create(x, y)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/red_slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Attributes
    obj.health = 40

    obj.vector = Vector:create(0, 0, obj.speed)

    function obj:spawnSlime()
        if (obj.foodSaturation >= SlimeMob.FOOD_SATURATION_MAX) then
            local spawnTypeSlime = math.random(4)
            if (spawnTypeSlime == 4) then
                table.insert(GameScene.mobs, SlimeMob:create(obj.x, obj.y))
            else
                table.insert(GameScene.mobs, RedSlimeMob:create(obj.x, obj.y))
            end
            obj.foodSaturation = obj.foodSaturation - SlimeMob.SPAWN_SATURATIONS_COST
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end