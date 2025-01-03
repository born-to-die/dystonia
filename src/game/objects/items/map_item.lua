---@class MapItem
MapItem = {}

---@param worldX number
---@param worldY number
---@return MapItem
function MapItem:create(worldX, worldY)

    local obj = {}

    -- Properties

    obj.worldX = worldX
    obj.worldY = worldY
    obj.item = nil

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