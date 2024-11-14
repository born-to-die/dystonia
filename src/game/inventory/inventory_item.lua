---@class InventoryItem
---@field name string
---@field sprite table
---@field type number|nil
---@field mapItem MapItem
---@field getMapItem fun(worldX:number, worldY:number): MapItem|nil For drop to map
---@field getObject fun(self, worldX:number, worldY:number): Object|nil For spawn on map
---@field use fun(self, player: Player)
InventoryItem = {}

function InventoryItem:create()

    local obj = {}

    -- Properties

    obj.name = nil
    obj.sprite = nil
    obj.type = nil

    -- Methods

    function obj:getSprite()
        return obj.sprite
    end

    function obj:getMapItem(worldX, worldY)
        return nil
    end

    function obj:getObject(worldX, worldY)
        return nil
    end

    function obj:use(player)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end