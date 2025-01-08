---@class RedSlimeMob
RedSlimeMob = {}

---@param x number
---@param y number
function RedSlimeMob:create(x, y)

    local obj = SlimeMob:create(x, y)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/red_slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    table.insert(obj.behaviors, MoveToAroundItem:new(obj, GameScene.items))

    -- Attributes
    obj.speed = 20
    obj.health = 40
    obj.foodSaturation = 100

    obj.vector = Vector:create(0, 0, obj.speed)

    function obj:spawnSlime()
        if (obj.foodSaturation >= 200) then
            local spawnTypeSlime = math.random(4)
            if (spawnTypeSlime == 4) then
                table.insert(GameScene.mobs, SlimeMob:create(obj.x, obj.y))
            else
                table.insert(GameScene.mobs, RedSlimeMob:create(obj.x, obj.y))
            end
            obj.foodSaturation = obj.foodSaturation - 100
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end