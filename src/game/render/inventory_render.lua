InventoryRender = {}

function InventoryRender:create()
  
  local obj = {}

  -- Properties

  -- Methods

  -- @param table inventory (Inventory)
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
  end
  
  setmetatable(obj, self)
    self.__index = self

    return obj
end