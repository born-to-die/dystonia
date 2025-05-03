MobsRender = {}

function MobsRender:create()
  
  local obj = {}

  --- @param mobs Mob[]
  function obj:render(mobs)
    local visibleTiles = BackgroundRender.visibleTiles
    local px, py = GameScene.PX, GameScene.PY
    local tileSizeX, tileSizeY = GFX_TILE_SCALE_X, GFX_TILE_SCALE_Y
    local tilePx = GFX_TILE_SIZE_PX
    local sx, sy = GameScene.SX, GameScene.SY
    local debugRender = DEBUG_RENDER
    
    for i = 1, #mobs do
      local mob = mobs[i]

      local wallTileX = math.floor((mob.x - px) / tileSizeX)
      local wallTileY = math.floor((mob.y - py) / tileSizeY)

      local row = visibleTiles[wallTileY]

      if
        (row and row[wallTileX])
        or DEBUG_RENDER
      then
        if (mob.alive == false) then
          love.graphics.setColor(0.25, 0.25, 0.25)
        else 
          love.graphics.setColor(1, 1, 1)
        end

        love.graphics.draw(
          mob.sprite,
          mob.x, mob.y,
          0,
          sx * mob.directionSprite, sy,
          mob.sprite:getWidth() / 2, mob.sprite:getHeight() / 2
        )

        if (mob.alive == false) then
          love.graphics.setColor(1, 1, 1)
          goto continue
        end

        if mob.currentAttackCooldown > 0 then
          local hitbox = mob:getAttackHitbox()
  
          love.graphics.circle(
            "fill",
            hitbox.x,
            hitbox.y,
            hitbox.radius
          )
        end

        if DEBUG_RENDER == true then
          love.graphics.setColor(1, 1, 0)
          love.graphics.circle("fill", mob.x, mob.y, 2)
          love.graphics.setColor(1, 1, 1)
  
          love.graphics.print("health: " .. mob.health, mob.x + tilePx / 2, mob.y - tilePx / 2)
          love.graphics.print("speed: " .. mob.speed, mob.x + tilePx / 2, mob.y - tilePx / 2 + tilePx * 0.25 * 1)
          love.graphics.print("vector x: " .. mob.vector.x, mob.x + tilePx / 2, mob.y - tilePx / 2 + tilePx * 0.25 * 2)
          love.graphics.print("vector y: " .. mob.vector.y, mob.x + tilePx / 2, mob.y - tilePx / 2 + tilePx * 0.25 * 3)
          love.graphics.print("food: " .. mob.foodSaturation, mob.x + tilePx / 2, mob.y - tilePx / 2 + tilePx * 0.25 * 4)
          love.graphics.print("behavior: " .. mob.behaviorName, mob.x + tilePx / 2, mob.y - tilePx / 2 + tilePx * 0.25 * 5)
  
          -- Draw direction vector
          local endX = mob.x + mob.vector.x * (mob.speed)
          local endY = mob.y + mob.vector.y * (mob.speed)
  
          love.graphics.line(mob.x, mob.y, endX, endY)
  
          local mob = mob;
  
          local hitbox = mob:getAttackHitbox()
  
          local hitboxDrawMode = "line"
          if mob.currentAttackCooldown > 0 then hitboxDrawMode = "fill" end
  
          love.graphics.circle(
            hitboxDrawMode,
            hitbox.x,
            hitbox.y,
            hitbox.radius
          )
        end
  
          ::continue::
      end
    end
    
    -- for i = 1, #mobs do

    --   local mobTileX = math.floor((mobs[i].x - GameScene.PX) / GFX_TILE_SCALE_X)
    --   local mobTileY = math.floor((mobs[i].y - GameScene.PY) / GFX_TILE_SCALE_Y)

    --   if
    --     BackgroundRender.visibleTiles == nil 
    --     or BackgroundRender.visibleTiles[mobTileY] == nil
    --     then
    --     goto continue
    --   end

    --   if (BackgroundRender.visibleTiles[mobTileY][mobTileX] == false) then
    --     goto continue
    --   end

    --   if (mobs[i].alive == false) then
    --     love.graphics.setColor(0.25, 0.25, 0.25)
    --   else 
    --     love.graphics.setColor(1, 1, 1)
    --   end

    --   love.graphics.draw(
    --     mobs[i].sprite,
    --     mobs[i].x,
    --     mobs[i].y,
    --     0,
    --     GameScene.SX * mobs[i].directionSprite, GameScene.SY,
    --     mobs[i].sprite:getWidth() / 2, mobs[i].sprite:getHeight() / 2
    --   )

    --   if (mobs[i].alive == false) then
    --     love.graphics.setColor(1, 1, 1)
    --     goto continue
    --   end

    --   if mobs[i].currentAttackCooldown > 0 then
    --     local hitbox = mobs[i]:getAttackHitbox()

    --     love.graphics.circle(
    --       "fill",
    --       hitbox.x,
    --       hitbox.y,
    --       hitbox.radius
    --     )
    --   end
      

    --   if DEBUG_RENDER == true then
    --     love.graphics.setColor(1, 1, 0)
    --     love.graphics.circle("fill", mobs[i].x, mobs[i].y, 2)
    --     love.graphics.setColor(1, 1, 1)

    --     love.graphics.print("health: " .. mobs[i].health, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2)
    --     love.graphics.print("speed: " .. mobs[i].speed, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 1)
    --     love.graphics.print("vector x: " .. mobs[i].vector.x, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 2)
    --     love.graphics.print("vector y: " .. mobs[i].vector.y, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 3)
    --     love.graphics.print("food: " .. mobs[i].foodSaturation, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 4)
    --     love.graphics.print("behavior: " .. mobs[i].behaviorName, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 5)

    --     -- Draw direction vector
    --     local endX = mobs[i].x + mobs[i].vector.x * (mobs[i].speed)
    --     local endY = mobs[i].y + mobs[i].vector.y * (mobs[i].speed)

    --     love.graphics.line(mobs[i].x, mobs[i].y, endX, endY)

    --     local mob = mobs[i];

    --     local hitbox = mob:getAttackHitbox()

    --     local hitboxDrawMode = "line"
    --     if mob.currentAttackCooldown > 0 then hitboxDrawMode = "fill" end

    --     love.graphics.circle(
    --       hitboxDrawMode,
    --       hitbox.x,
    --       hitbox.y,
    --       hitbox.radius
    --     )
    --   end

    --     ::continue::
    -- end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end