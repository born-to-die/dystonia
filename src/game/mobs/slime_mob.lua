---@class SlimeMob : Mob
SlimeMob = {};

SlimeMob.FOOD_SATURATION_MAX = 400
SlimeMob.MUSHROOMS_SATURATION_POINTS = 200
SlimeMob.SPAWN_SATURATIONS_COST = 175

---@param x number
---@param y number
function SlimeMob:create(x, y)

    local obj = Mob:create(x, y)

    -- Properties

    obj.name = "SlimeMob"
    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Attributes
    obj.health = 40
    obj.foodSaturation = 200

    obj.vector = Vector:create(0, 0, self.SPEED)

    table.insert(obj.behaviors, MoveToAroundPlayer:new(obj))
    table.insert(obj.behaviors, MoveToAroundItem:new(obj, GameScene.items))
    table.insert(obj.behaviors, MoveRandomly:new(obj))

    -- Methods

    function obj:specifyUpdate()

        for index, item in ipairs(GameScene.items) do

            if item == nil then
                goto continue
            end

            if item.name == BlueMushroomMapItem.name then
                if MathService:distance(obj, item) < GFX_TILE_SIZE_PX / 2 then
                    item.deleted = true
                    table.remove(GameScene.items, index)
                    obj.foodSaturation = obj.foodSaturation + SlimeMob.MUSHROOMS_SATURATION_POINTS
                    if (obj.foodSaturation > SlimeMob.FOOD_SATURATION_MAX) then
                        obj.foodSaturation = SlimeMob.FOOD_SATURATION_MAX
                    end
                end
            end
            ::continue::
        end

        obj:spawnSlime()
    end

    function obj:spawnSlime()
        if (obj.foodSaturation >= SlimeMob.FOOD_SATURATION_MAX) then
            local spawnTypeSlime = math.random(6)
            if spawnTypeSlime == 1 then
                table.insert(GameScene.mobs, RedSlimeMob:create(obj.x, obj.y))
            elseif spawnTypeSlime == 2 or spawnTypeSlime == 3 then
                table.insert(GameScene.mobs, SlimeMob:create(obj.x, obj.y))
            else
                local tx = math.floor((obj.x - GAME_SCENE.PX) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))
                local ty = math.floor((obj.y - GAME_SCENE.PY) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))
                table.insert(GameScene.items, SlimeMapItem:create(tx, ty))
            end

            obj.foodSaturation = obj.foodSaturation - SlimeMob.SPAWN_SATURATIONS_COST
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end