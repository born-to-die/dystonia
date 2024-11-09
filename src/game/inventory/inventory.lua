Inventory = {}

function Inventory:create()

    local obj = {}

    -- Properties

    obj.items = {} -- InventoryItem[]

    -- Methods

    -- @return table - InventoryItem's array
    function obj:getAll()
        return obj.items
    end

    -- @return int
    function obj:count()
        return #obj.items
    end

    -- @param InventoryItem item
    function obj:add(item)
        table.insert(obj.items, item)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end