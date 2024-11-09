---@class Object
---@field worldX number
---@field worldY number
---@field sprite table
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

    -- Methods

    ---@return table
    function obj:getSprite()
        return obj.sprite
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end