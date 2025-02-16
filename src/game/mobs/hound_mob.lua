---@class HoundMob : Mob
HoundMob = {};

---@param x number
---@param y number
---@return HoundMob
function HoundMob:create(x, y)

    ---@class obj: HoundMob
    local obj = Mob:create(x, y)

    -- Properties

    obj.name = "HoundMob"
    obj.sprite = love.graphics.newImage("gfx/hound_mob.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)

    -- Attributes
    obj.health = 60
    obj.speed = 200
    obj.damage = 20
    obj.isEating = false

    obj.vector = Vector:create(0, 0, obj.speed)

    table.insert(obj.behaviors, 1, MoveToAroundPlayer:new(obj, 0))

    -- Methods

    function obj:specifyUpdate()
        obj.directionSprite = -1
        if GameScene.player.x > obj.x then
            obj.directionSprite = 1
        end

        local hitbox = obj:getAttackHitbox()

        if obj.inAttack == false then
            for i,wall in ipairs(GameScene.walls) do
                local ic = CollisionChecker:isPointInCircle(
                    hitbox.x,
                    hitbox.y,
                    hitbox.radius,
                    wall.pointX,
                    wall.pointY
                )
    
                if ic == true then
                    obj.attack()
                    return
                end
            end
        end
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end