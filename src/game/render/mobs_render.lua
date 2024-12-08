MobsRender = {}

function MobsRender:create()
  
  local obj = {}

  --- @param mobs Mob
  function obj:render(mobs)
    
    for i = 1, #mobs do
      love.graphics.draw(
        mobs[i].sprite,
        mobs[i].x,
        mobs[i].y,
        0,
        GameScene.SX, GameScene.SY,
        mobs[i].sprite:getWidth() / 2, mobs[i].sprite:getHeight() / 2
      )

      if DEBUG_RENDER == true then
        love.graphics.setColor(1, 1, 0)
        love.graphics.circle("fill", mobs[i].x, mobs[i].y, 2)
        love.graphics.setColor(1, 1, 1)

        love.graphics.print("health: " .. mobs[i].health, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2)
        love.graphics.print("speed: " .. mobs[i].speed, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 1)
        love.graphics.print("food: " .. mobs[i].foodSaturation, mobs[i].x + GFX_TILE_SIZE_PX / 2, mobs[i].y - GFX_TILE_SIZE_PX / 2 + GFX_TILE_SIZE_PX * 0.25 * 2)
      end
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end