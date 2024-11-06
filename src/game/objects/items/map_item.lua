MapItem = {}

-- @param int worldX
-- @param int worldY
function MapItem:create(worldX, worldY)

    local obj = {}

    -- Properties

    obj.worldX = worldX
    obj.worldY = worldY

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end