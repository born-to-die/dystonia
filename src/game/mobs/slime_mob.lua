---@class SlimeMob
---@field worldX number
---@field worldY number
SlimeMob = {};

-- @param int worldX
-- @param int worldY
function SlimeMob:create(worldX, worldY)

    local obj = Mob:create(worldX, worldY)

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    table.insert(obj.behaviors, MoveRandomly:new(obj))

    -- Attributes
    obj.speed = 200
    obj.health = 40
    obj.foodSaturation = 10000

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
                end
            end
            ::continue::
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end