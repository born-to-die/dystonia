---@class PlayerRender
---@field FOOD_BAR_COLOR table
---@field FONT_DEFAULT_COLOR table
PlayerRender = {}

-- Colors
PlayerRender.FOOD_BAR_COLOR = {217 / 255, 116 / 255, 49 / 255, 1}
PlayerRender.HEALTH_BAR_COLOR = {63 / 255, 149 / 255, 103 / 255, 1}
PlayerRender.INVENTORY_COLOR = {106 / 255, 106 / 255, 107 / 255, 0.5}
PlayerRender.FONT_DEFAULT_COLOR = {1, 1, 1}

love.graphics.setLineStyle("rough")
love.graphics.setLineWidth(1)

function PlayerRender:create()
  
  local obj = {}
  
  ---@param player Player
  ---@param px number
  ---@param py number
  ---@param scaleX number
  ---@param scaleY number
  function obj:render(player, px, py, scaleX, scaleY)
    
    love.graphics.draw(
        player.sprite,
        player.x,
        player.y,
        0, 
        scaleX * player.directionX, scaleY,
        player.sprite:getWidth() / 2, player.sprite:getHeight() / 2
    )

    -- Attacks hitbox render
    if player.currentAttackCooldown > 0 then
      local hitbox = player:getAttackHitbox()

      love.graphics.circle(
        "fill",
        hitbox.x,
        hitbox.y,
        hitbox.radius
      )
    end

    love.graphics.setFont(GameScene.FONT_MEDIUM)
    love.graphics.print("TIME: " .. GameScene.inGameTime .. " MINS", 64, 96)

    -- Health bar
    love.graphics.setColor(PlayerRender.HEALTH_BAR_COLOR)
    love.graphics.rectangle('fill', 64, 172, player.health * 164 / 100, 24)
    love.graphics.rectangle('line', 62, 170, 169, 29)
    love.graphics.setColor(PlayerRender.FONT_DEFAULT_COLOR)
    love.graphics.setFont(GameScene.FONT_SUB_MEDIUM)
    love.graphics.print("HEALTH: " .. player.health .. "%", 68, 174)
    love.graphics.setFont(GameScene.FONT_DEFAULT)

    -- Food bar
    love.graphics.setColor(PlayerRender.FOOD_BAR_COLOR)
    love.graphics.rectangle('fill', 64, 212, player.foodSaturation * 164 / 100, 24)
    love.graphics.rectangle('line', 62, 210, 169, 29)
    love.graphics.setColor(PlayerRender.FONT_DEFAULT_COLOR)
    love.graphics.setFont(GameScene.FONT_SUB_MEDIUM)
    love.graphics.print("FOOD: " .. player.foodSaturation .. "%", 68, 214)
    love.graphics.setFont(GameScene.FONT_DEFAULT)
    
    if DEBUG_RENDER == true then
      obj:debugRender(player, player.x, player.y, px, py)
    end
  end
  
  ---@param player Player
  function obj:debugRender(player, playerX, playerY, px, py)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", playerX, playerY, 2)
    love.graphics.setColor(1, 1, 1)
    
    local playerText = 
        "Player: " .. playerX .. ":" .. playerY .. 
        " (" .. player.worldX .. ":" .. player.worldY .. ")"

    love.graphics.print(playerText, 0, 0)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 15)
    love.graphics.print("RAM: " .. math.ceil(collectgarbage("count") / 1024) .. "MB", 0, 30)

    local hitbox = player:getAttackHitbox()

    love.graphics.circle(
      "line",
      hitbox.x,
      hitbox.y,
      hitbox.radius
    )
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end