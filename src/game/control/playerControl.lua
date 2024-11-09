PlayerControl = {}

function PlayerControl:create()
  
  local obj = {}
  
    obj.keyRightPressed = false
    obj.keyDownPressed = false
    obj.keyLeftPressed = false
    obj.keyUpPressed = false
    obj.keyEscapePressed = false
    obj.keySpacePressed = false
    
    -- @param table player - Player
    -- @param float deltaTime
    -- @param table items - Item[]
    -- @param table inventory - Inventory
    function obj:update(player, deltaTime, items, inventory)
    
      -- Movement
      obj.keyRightPressed = love.keyboard.isDown(PC_RIGHT)
      obj.keyDownPressed = love.keyboard.isDown(PC_DOWN)
      obj.keyLeftPressed = love.keyboard.isDown(PC_LEFT)
      obj.keyUpPressed = love.keyboard.isDown(PC_UP)

      -- Actions
      obj.keySpacePressed = love.keyboard.isDown(PC_ACTION)
      obj.keyEscapePressed = love.keyboard.isDown("escape")
    
      if obj.keyRightPressed == true then
        player.directionX = 1
        player.vector:setX(1, 150 * deltaTime)
      end
      
      if obj.keyDownPressed == true then
        player.vector:setY(1, 150 * deltaTime)
      end

      if obj.keyLeftPressed == true then
          player.directionX = -1
          player.vector:setX(-1, 150 * deltaTime)
      end

      if obj.keyUpPressed == true then
        player.vector:setY(-1, 150 * deltaTime)
      end

      if obj.keySpacePressed == true then
        
        for i = 1, #items, 1 do
          if items[i].worldX == player.worldX and items[i].worldY == player.worldY then
            inventory:add(items[i]:getItem())
            table.remove(items, 1)
          end
        end
      end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end