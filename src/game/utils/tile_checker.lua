TileChecker = {}

function TileChecker:create()

    local obj = {}

    -- Properties

    -- Methods

    -- @param int x
    -- @param int y
    -- @param table a like list (array)
    function obj:isFreeTileForList(x, y, array)
        for i = 1, #array do
            if array[i].worldX == x and array[i].worldY == y then
                return false
            end
        end

        return true
    end

    -- @param int x
    -- @param int y
    -- @param table object like object
    function obj:isFreeTileForObject(x, y, object)
        return not (object.worldX == x and object.worldY == y)
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end