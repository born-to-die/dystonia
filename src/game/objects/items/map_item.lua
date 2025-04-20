---@class MapItem
---@field name string
---@field x number
---@field y number
---@field worldX integer
---@field worldY integer
---@field sprite table
---@field deleted boolean
MapItem = {}

---@param worldX number
---@param worldY number
---@return MapItem
function MapItem:create(worldX, worldY)

    local obj = {}

    -- Properties

    obj.name = 'item_name'
    obj.worldX = worldX
    obj.worldY = worldY
    obj.x = worldX * GFX_TILE_SIZE_PX * GameScene.SX + GameScene.PX + GFX_TILE_SIZE_PX / 2
    obj.y = worldY * GFX_TILE_SIZE_PX * GameScene.SY + GameScene.PY + GFX_TILE_SIZE_PX / 2
    obj.item = nil
    obj.deleted = false

    -- Methods

    -- @return table (InventoryItem)
    function obj:getItem()
        return obj.item
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end