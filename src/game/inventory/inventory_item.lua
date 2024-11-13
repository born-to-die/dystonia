---@class InventoryItem
---@field name string
---@field sprite table
---@field mapItem MapItem
---@field getMapItem fun(worldX:number, worldY:number): MapItem|nil
---@field getObject fun(worldX:number, worldY:number): Object|nil
InventoryItem = {}

function InventoryItem:create()

    local obj = {}

    -- Properties

    obj.name = nil
    obj.sprite = nil

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

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end