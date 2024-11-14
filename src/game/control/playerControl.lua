PlayerControl = {}

function PlayerControl:create()
  
  local obj = {}
  
    obj.keyRightPressed = false
    obj.keyDownPressed = false
    obj.keyLeftPressed = false
    obj.keyUpPressed = false
    obj.keyEscapePressed = false
    obj.keySpacePressed = false
    obj.rightArrowPressed = false
    obj.leftArrowPressed = false
    
    ---@param player Player
    ---@param inventory Inventory
    function obj:update(player, deltaTime, items, inventory)
    
      -- Movement
      obj.keyRightPressed = love.keyboard.isDown(PC_RIGHT)
      obj.keyDownPressed = love.keyboard.isDown(PC_DOWN)
      obj.keyLeftPressed = love.keyboard.isDown(PC_LEFT)
      obj.keyUpPressed = love.keyboard.isDown(PC_UP)

      -- Actions
      obj.keySpacePressed = love.keyboard.isDown(PC_ACTION)
      obj.keyEscapePressed = love.keyboard.isDown("escape")
    
      if obj.keyRightPressed == true and player.x < GameScene.MAP_RIGHT_BORDER then
        player.directionX = 1
        player.vector:setX(1, 150 * deltaTime)
      end
      
      if obj.keyDownPressed == true and player.y < GameScene.MAP_BOTTOM_BORDER then
        player.vector:setY(1, 150 * deltaTime)
      end

      if obj.keyLeftPressed == true and player.x > GameScene.MAP_LEFT_BORDER then
          player.directionX = -1
          player.vector:setX(-1, 150 * deltaTime)
      end

      if obj.keyUpPressed == true and player.y > GameScene.MAP_TOP_BORDER then
        player.vector:setY(-1, 150 * deltaTime)
      end
  end

  ---@param key string
  ---@param player Player
  ---@param inventory Inventory
  ---@param items MapItem[]
  ---@param objects Object[]
  function obj:keypressed(key, player, inventory, items, objects)

    if key == "left" then

      local activeSlot = inventory.items[inventory.selectedSlotNumber]

      if activeSlot == nil then
        return
      end

      table.insert(objects, inventory.items[inventory.selectedSlotNumber]:getObject(player.worldX, player.worldY))
      table.remove(inventory.items, inventory.selectedSlotNumber)


    elseif key == "space" then
      for i = 1, #items, 1 do
        if items[i].worldX == player.worldX and items[i].worldY == player.worldY then
          local isAdded = inventory:add(items[i]:getItem())
          if isAdded then
            table.remove(items, i)
          end
          break
        end
      end

    elseif key == 'up' and inventory.selectedSlotNumber > 1 then
      inventory.selectedSlotNumber = inventory.selectedSlotNumber - 1
    elseif key == 'down' and inventory.selectedSlotNumber < 5 then
      inventory.selectedSlotNumber = inventory.selectedSlotNumber + 1

    elseif key == "x" then
      table.insert(items, inventory.items[inventory.selectedSlotNumber]:getMapItem(player.worldX, player.worldY))
      table.remove(inventory.items, inventory.selectedSlotNumber)
    

    elseif key == "e" then
      for i = 1, #objects do

        local object = objects[i]

        if (object == nil) then
          break
        end

        local isPlayerActivity = object.type == 'player-activity'
        local isCloseToPlayer = object.worldX == player.worldX and object.worldY == player.worldY

        if isPlayerActivity and isCloseToPlayer then
          object:activate(items)
          table.remove(objects, i)
        end
      end
    end
  end

  ---@param x number
  ---@param y number
  ---@param inventory Inventory
  function obj:wheelmoved(x, y, inventory)
    if y > 0 and inventory.selectedSlotNumber > 1 then
      inventory.selectedSlotNumber = inventory.selectedSlotNumber - 1
    elseif y < 0 and inventory.selectedSlotNumber < 5 then
      inventory.selectedSlotNumber = inventory.selectedSlotNumber + 1
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end