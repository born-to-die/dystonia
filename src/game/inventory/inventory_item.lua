InventoryItem = {}

function InventoryItem:create()

    local obj = {}

    -- Properties

    obj.name = nil

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end