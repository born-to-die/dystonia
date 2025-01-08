InventoryRender = {}

function InventoryRender:create()
  
  local obj = {}

  -- Properties

  -- Methods

  ---@param inventory Inventory
  function obj:render(inventory)
    
    local items = inventory.getAll()

    -- Inventory background slots
    love.graphics.setColor(PlayerRender.INVENTORY_COLOR)
    for i = 1, inventory.capacity, 1 do
      love.graphics.rectangle(
        "fill",
        960,
        64 + GFX_TILE_SIZE_PX * i * 1.25,
        64,
        64,
        8
      )
    end
    love.graphics.setColor(PlayerRender.FONT_DEFAULT_COLOR)

    -- Items in slots
    for i = 1, inventory:count() do
      love.graphics.draw(
        items[i]:getSprite(),
        960,
        64 + GFX_TILE_SIZE_PX * i * 1.25,
        0,
        GameScene.SX, GameScene.SY
      )
    end

    -- Inventory active border
    love.graphics.rectangle(
      "line",
      960,
      GFX_TILE_SIZE_PX + inventory.selectedSlotNumber * GFX_TILE_SIZE_PX * 1.25,
      64,
      64,
      8
    )

    local activeItem = inventory.items[inventory.selectedSlotNumber]
    local activeItemName = ''

    if activeItem then
      activeItemName = activeItem.name
    end

    love.graphics.setFont(GameScene.FONT_MEDIUM)
    love.graphics.print(activeItemName, 1050, 140)
    -- TODO Its for desc-ons of items
    -- love.graphics.setFont(GameScene.FONT_SUB_MEDIUM)
    -- love.graphics.printf("Draws formatted text, with word wrap and alignment. ", 1050, 180, 200, "left")
    love.graphics.setFont(GameScene.FONT_DEFAULT)
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end