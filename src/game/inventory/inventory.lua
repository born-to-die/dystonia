Inventory = {}

function Inventory:create()

    local obj = {}

    -- Properties

    obj.items = {} -- InventoryItem[]

    -- Methods

    -- @param InventoryItem item
    function obj:add(item)
        table.insert(obj.items, item)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end