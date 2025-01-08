---@class SlimeMob
SlimeMob = {};

---@param x number
---@param y number
function SlimeMob:create(x, y)

    local obj = Mob:create(x, y)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    -- table.insert(obj.behaviors, MoveRandomly:new(obj))
    -- table.insert(obj.behaviors, MoveToAroundItem:new(obj, GameScene.items))

    -- Attributes
    obj.speed = 20
    obj.health = 40
    obj.foodSaturation = 100

    obj.vector = Vector:create(0, 0, obj.speed)

    -- Methods

    function obj:specifyUpdate()

        for index, item in ipairs(GameScene.items) do

            if item == nil then
                goto continue
            end

            if item.name == BlueMushroomMapItem.name then
                if MathService:distance(obj, item) < GFX_TILE_SIZE_PX / 2 then
                    table.remove(GameScene.items, index)
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