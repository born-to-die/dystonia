---@class Inventory
---@field items InventoryItem[]
---@field selectedSlotNumber number
---@field capacity number
---@field getAll fun():InventoryItem[]
---@field count fun():number
---@field add fun(self, item:InventoryItem): boolean
---@field remove fun(pos:number)
Inventory = {}

function Inventory:create()

    local obj = {}

    -- Properties

    obj.items = {} -- InventoryItem[]
    obj.selectedSlotNumber = 1
    obj.capacity = 5

    -- Methods

    ---@deprecated Use just .items directly
    function obj:getAll()
        return obj.items
    end

    -- @return int
    function obj:count()
        return #obj.items
    end

    ---@param item InventoryItem
    function obj:add(item)
        if #obj.items == obj.capacity then
            return false
        end

        table.insert(obj.items, item)
        return true
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