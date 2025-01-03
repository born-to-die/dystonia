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
    function obj:update(
      player,
      deltaTime,
      items,
      inventory
    )
      -- DIRECTION

      local mx, my = love.mouse.getPosition()

      if mx > player.x then
        player.directionX = 1
      else
        player.directionX = -1
      end

      -- ATTACKS

      -- Attack frame time
      if player.currentAttackFrameTime > 0 then
        player.currentAttackFrameTime = player.currentAttackFrameTime - GameScene.DT

        if (player.inAttack == true) then
          for i = 1, #GameScene.mobs, 1 do
            local hitbox = player:getAttackHitbox()
            
            local ic = CollisionChecker:isPointInCircle(
              hitbox.x,
              hitbox.y,
              hitbox.radius,
              GameScene.mobs[i].x,
              GameScene.mobs[i].y
            )

            if ic == true then
              GameScene.mobs[i].health = GameScene.mobs[i].health - player.damage
              player.inAttack = false
            end
          end
        end
      end

      -- Attack cooldown time
      if player.currentAttackCooldown > 0 then
        player.currentAttackCooldown = player.currentAttackCooldown - GameScene.DT
      end
    
      -- Movement
      obj.keyRightPressed = love.keyboard.isDown(PC_RIGHT)
      obj.keyDownPressed = love.keyboard.isDown(PC_DOWN)
      obj.keyLeftPressed = love.keyboard.isDown(PC_LEFT)
      obj.keyUpPressed = love.keyboard.isDown(PC_UP)

      -- Actions
      obj.keySpacePressed = love.keyboard.isDown(PC_ACTION)
      obj.keyEscapePressed = love.keyboard.isDown("escape")
    
      if obj.keyRightPressed == true and player.x < GameScene.MAP_RIGHT_BORDER then
        player.vector:setX(1, player.speed)
      end
      
      if obj.keyDownPressed == true and player.y < GameScene.MAP_BOTTOM_BORDER then
        player.vector:setY(1, player.speed)
      end

      if obj.keyLeftPressed == true and player.x > GameScene.MAP_LEFT_BORDER then
          player.vector:setX(-1, player.speed)
      end

      if obj.keyUpPressed == true and player.y > GameScene.MAP_TOP_BORDER then
        player.vector:setY(-1, player.speed)
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

      if activeSlot.type == InventoryItemType.OBJECT then
        table.insert(objects, inventory.items[inventory.selectedSlotNumber]:getObject(player.worldX, player.worldY))
      elseif activeSlot.type == InventoryItemType.USE then
        activeSlot:use(player)
      end

      
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

  function obj:mousepressed(button)
    -- LMB: Attack
    if button == 1 then
      local player = GAME_SCENE.player
      if player.currentAttackCooldown <= 0 then
        player.currentAttackCooldown = player.attackCooldown
        player.currentAttackFrameTime = player.attackFrameTime
        player.inAttack = true
      end
    -- RMB: Take/Active items/objects
    elseif button == 2 then
      for i = 1, #GameScene.items, 1 do
        if GameScene.items[i].worldX == GameScene.player.worldX and GameScene.items[i].worldY == GameScene.player.worldY then
          local isAdded = GameScene.inventory:add(GameScene.items[i]:getItem())
          if isAdded then
            table.remove(GameScene.items, i)
          end
          break
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
    elseif y < 0 and inventory.selectedSlotNumber < GameScene.inventory.capacity then
      inventory.selectedSlotNumber = inventory.selectedSlotNumber + 1
    end
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end