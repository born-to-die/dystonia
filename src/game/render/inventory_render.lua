InventoryRender = {}

function InventoryRender:create()
  
  local obj = {}

  -- Properties

  -- Methods

  ---@param inventory Inventory
  function obj:render(inventory)
    
    local items = inventory.getAll()

    for i = 1, inventory:count() do
      love.graphics.draw(
        items[i]:getSprite(),
        896 + GFX_TILE_SIZE_PX * i,
        64,
        0,
        GameScene.SX, GameScene.SY
    )
    end

    love.graphics.rectangle(
      "line",
      832 + GFX_TILE_SIZE_PX + inventory.selectedSlotNumber * GFX_TILE_SIZE_PX,
      64,
      64,
      64
    )
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end