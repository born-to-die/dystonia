---@class SlimeMob
SlimeMob = {};

---@param x number
---@param y number
function SlimeMob:create(x, y)

    local obj = Mob:create(x, y)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    table.insert(obj.behaviors, MoveRandomly:new(obj))

    -- Attributes
    obj.speed = 200
    obj.health = 40
    obj.foodSaturation = 100

    obj.vector = Vector:create(0, 0, obj.speed)

    -- Methods

    function obj:specifyUpdate()
        for i = 1, #GameScene.objects do

            if GameScene.objects[i] == nil then
                goto continue
            end

            if GameScene.objects[i].name == "blue-mushrooms" then
                if GameScene.mathService:distance(obj, GameScene.objects[i]) < 50 then
                    table.remove(GameScene.objects, i)
                    obj.foodSaturation = obj.foodSaturation + 30
                end
            end
            ::continue::
        end

        obj:spawnSlime()
    end

    function obj:spawnSlime()
        if (obj.foodSaturation >= 200) then
            local spawnTypeSlime = math.random(4)
            if (spawnTypeSlime == 4) then
                table.insert(GameScene.mobs, RedSlimeMob:create(obj.x, obj.y))
            else
                table.insert(GameScene.mobs, SlimeMob:create(obj.x, obj.y))
            end
            obj.foodSaturation = obj.foodSaturation - 100
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end