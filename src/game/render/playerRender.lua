---@class PlayerRender
PlayerRender = {}

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

    love.graphics.setFont(GameScene.FONT_MEDIUM)
    love.graphics.print("TIME: " .. GameScene.inGameTime .. " MINS", 64, 96)
    love.graphics.print("FOOD: " .. player.foodSaturation .. "%", 64, 128)
    love.graphics.setFont(GameScene.FONT_DEFAULT)
    
    if DEBUG_RENDER == true then
      obj:debugRender(player, player.x, player.y, px, py)
    end
  end
  
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
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end