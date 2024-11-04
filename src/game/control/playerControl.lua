PlayerControl = {}

function PlayerControl:create()
  
  local obj = {}
  
    obj.keyRightPressed = false
    obj.keyDownPressed = false
    obj.keyLeftPressed = false
    obj.keyUpPressed = false
    obj.keyEscapePressed = false
    obj.keySpacePressed = false
    
  function obj:update(player, deltaTime)
    
    obj.keyRightPressed = love.keyboard.isDown("d")
    obj.keyDownPressed = love.keyboard.isDown("s")
    obj.keyLeftPressed = love.keyboard.isDown("a")
    obj.keyUpPressed = love.keyboard.isDown("w")
    obj.keyEscapePressed = love.keyboard.isDown("escape")

    obj.keySpacePressed = love.keyboard.isDown("space")
    
    if obj.keyRightPressed == true then
      player.directionX = 1
      player.vector:setX(1, 150 * deltaTime)
      --player.x = player.x + 150 * deltaTime
    end
    
    if obj.keyDownPressed == true then
      player.vector:setY(1, 150 * deltaTime)
        --player.y = player.y + 150 * deltaTime
    end

    if obj.keyLeftPressed == true then
        player.directionX = -1
        player.vector:setX(-1, 150 * deltaTime)
        --player.x = player.x - 150 * deltaTime
    end

    if obj.keyUpPressed == true then
      player.vector:setY(-1, 150 * deltaTime)
        --player.y = player.y - 150 * deltaTime
    end

    if obj.keySpacePressed == true then
      print(love.timer.getTime())
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end