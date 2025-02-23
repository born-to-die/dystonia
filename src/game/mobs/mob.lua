---@class Mob
---@field x number
---@field y number
---@field update fun()
---@field moveRandomly fun()
---@field behaviors Behavior[]
---@field name string
---@field speed number
---@field health number
---@field alive boolean
---@field directionSprite number
---@field inAttack boolean
---@field isEating boolean
---@field foodSaturation number
---@field vector Vector
---@field attack function
---@field currentAttackCooldown boolean
Mob = {}

Mob.SATURATION_DECREASE_DEFAULT_TIME = 1
Mob.SPEED_DEFAULT = 60

---@param x number
---@param y number
---@return Mob
function Mob:create(x, y)

    local obj = {}

    -- Properties

    obj.sprite = love.graphics.newImage("gfx/slime_mob.png")

    -- Position & Movement
    obj.worldX = 5
    obj.worldY = 5
    obj.x = x
    obj.y = y

    -- Attacks properties
    obj.damage = 10
    obj.attackRadius = 20
    obj.inAttack = false
    obj.attackCooldown = 2
    obj.currentAttackCooldown = 0
    obj.attackFrameTime = 1
    obj.currentAttackFrameTime = 0
    
    -- Attributes
    obj.behaviors = {}
    obj.behaviorName = ''

    obj.name = 'Mob'
    obj.alive = true
    obj.directionSprite = 1
    obj.speed = Mob.SPEED_DEFAULT
    obj.health = 40
    obj.isEating = true
    obj.foodSaturation = 100
    obj.toDel = false

    obj.vector = Vector:create(0, 0, obj.speed)

    -- Methods

    obj.call = function ()
        obj:foodSaturationUpdate()
    end

    obj.foodSaturationIntervalTimer = TIMER(Mob.SATURATION_DECREASE_DEFAULT_TIME, obj.call)

    function obj:update()

        if obj.alive == false then
            obj:deathUpdate()
            return
        end

        if obj.health <= 0 and obj.alive == true then
            obj.alive = false
            obj:die()
            return
        end

        -- Attack frame time
      if obj.currentAttackFrameTime > 0 then
        obj.currentAttackFrameTime = obj.currentAttackFrameTime - GameScene.DT

        if (obj.inAttack == true) then
            local hitbox = obj:getAttackHitbox()
            
            local ic = CollisionChecker:isPointInCircle(
              hitbox.x,
              hitbox.y,
              hitbox.radius,
              GameScene.player.x,
              GameScene.player.y
            )

            if ic == true then
              GameScene.player.health = GameScene.player.health - obj.damage
              obj.inAttack = false
              goto cont
            end

            for i,wall in ipairs(GameScene.walls) do
                local ic = CollisionChecker:isCircleRectangleCollition(
                    hitbox.x,
                    hitbox.y,
                    hitbox.radius,
                    wall.x,
                    wall.y,
                    GFX_TILE_SIZE_PX,
                    GFX_TILE_SIZE_PX
                )
    
                if ic == true then
                    wall:addDamage(obj.damage)
    
                    if wall.health <= 0 then
                        table.remove(GameScene.walls, i)
                    end
    
                    obj.inAttack = false
                    goto cont
                end
            end
        end
      end

      ::cont::

      -- Attack cooldown time
      if obj.currentAttackCooldown > 0 then
        obj.currentAttackCooldown = obj.currentAttackCooldown - GameScene.DT
      end

        for i = 1, #obj.behaviors, 1 do
            if obj.behaviors[i]:canExecute() then
                obj.behaviorName = obj.behaviors[i].name
                obj.behaviors[i]:execute(self)
                break
            end
        end

        if obj.isEating then
            obj:foodSaturationUpdate()
        end

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

            self.foodSaturationIntervalTimer = TIMER(Mob.SATURATION_DECREASE_DEFAULT_TIME, self.call)
            return true
        end
    end

    function obj:deathUpdate()
        self:specifyDeathUpdate()
    end

    function obj:die()
        self:specifyDie()
    end

    ---@param x number
    ---@param y number
    function obj:setPosition(x, y)
        obj.x = x
        obj.y = y
    end

    function obj:attack()
        if obj.currentAttackCooldown <= 0 then
            obj.currentAttackCooldown = obj.attackCooldown
            obj.currentAttackFrameTime = obj.attackFrameTime
            obj.inAttack = true
          end
    end

    function obj:getAttackHitbox()
        local hitbox = {}

        local ex = obj.x + obj.vector.x * (obj.speed)
        local ey = obj.y + obj.vector.y * (obj.speed)
    
        hitbox.angle = math.atan2(ey - obj.y, ex - obj.x)
        hitbox.radius = obj.attackRadius
        hitbox.x = obj.x + math.cos(hitbox.angle) * hitbox.radius
        hitbox.y = obj.y + math.sin(hitbox.angle) * hitbox.radius
    
        return hitbox
    end

    -- Special method for child classes, 
    -- called after update() the parent class
    function obj:specifyUpdate()
        -- Your events here
    end

    -- Special method for child classes, 
    -- called after die() the parent class
    function obj:specifyDie()
        -- Your events here
    end

    function obj:specifyDeathUpdate()
        -- TODO
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end
