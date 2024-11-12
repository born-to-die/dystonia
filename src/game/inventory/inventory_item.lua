---@class InventoryItem
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

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end