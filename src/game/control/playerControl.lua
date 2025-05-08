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

      if player.health <= 0 then
        return
      end

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
          local hitbox = player:getAttackHitbox()

          for i = 1, #GameScene.mobs, 1 do

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
              return
            end
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
              wall:addDamage(player.damage)
              if wall.health <= 0 then
                GameScene.wallsService:deleteWall(wall, i)
              end
              player.inAttack = false
              return
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

    if key == "e" then

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
      local item = inventory.items[inventory.selectedSlotNumber]

      if item == nil then
        return
      end

      local mapItem = item:getMapItem(player.worldX, player.worldY);

      if (item) then
        table.insert(items, mapItem)
        table.remove(inventory.items, inventory.selectedSlotNumber)
      end

    elseif key == "f5" then
      DEBUG_RENDER = not DEBUG_RENDER

    elseif key == "f9" then
      table.insert(GameScene.mobs, SlimeMob:create(player.x + 128, player.y + 128))

    elseif key == "f11" then
      love.window.setFullscreen(not love.window.getFullscreen())
  
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
      -- Take item
      for i = 1, #GameScene.items do
        if GameScene.items[i].worldX == GameScene.player.worldX and GameScene.items[i].worldY == GameScene.player.worldY then
          local isAdded = GameScene.inventory:add(GameScene.items[i]:getItem())
          if isAdded then
            GameScene.items[i].deleted = true
            table.remove(GameScene.items, i)
            return
          end
          break
        end
      end

      -- Activate object
      for i = 1, #GameScene.objects do
        local object = GameScene.objects[i]

        if (object == nil) then
          break
        end

        local isPlayerActivity = object.type == 'player-activity'
        local isCloseToPlayer = object.worldX == GameScene.player.worldX and object.worldY == GameScene.player.worldY

        if isPlayerActivity and isCloseToPlayer then
          object:activate(items)
          table.remove(GameScene.objects, i)
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