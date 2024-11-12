---@class Inventory
---@field items InventoryItem[]
---@field selectedSlotNumber number
---@field getAll fun():InventoryItem[]
---@field count fun():number
---@field add fun(item:InventoryItem)
---@field remove fun(pos:number)
Inventory = {}

function Inventory:create()

    local obj = {}

    -- Properties

    obj.items = {} -- InventoryItem[]
    obj.selectedSlotNumber = 1

    -- Methods

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

    ---@param pos number
    function obj:remove(pos)
        table.remove(obj.items, pos)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end