---@class Object
---@field worldX number
---@field worldY number
---@field sprite table
---@field type string
---@field activate fun(self, items: MapItem[]) called when the player activates object
Object = {}

---@param worldX number
---@param worldY number
---@return table
function Object:create(worldX, worldY)

    local obj = {}

    -- Properties

    obj.worldX = worldX
    obj.worldY = worldY
    obj.sprite = nil
    obj.type = nil

    -- Methods

    ---@return table
    function obj:getSprite()
        return obj.sprite
    end

    function obj:activate(items)
        -- actions
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end