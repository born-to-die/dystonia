TileChecker = {}

function TileChecker:create()

    local obj = {}

    -- Properties

    -- Methods

    ---@param tx number
    ---@param ty number
    ---@return boolean
    function obj:isFreeTile(tx, ty)

        local isFreeTielFromPlayer self:isFreeTileForObject(tx, ty, GameScene.player)
        if isFreeTielFromPlayer == false then return false end

        local isFreeTileFromWalls = self:isFreeTileForList(tx, ty, GameScene.walls)
        if isFreeTileFromWalls == false then return false end

        local isFreeTileFromObjects = self:isFreeTileForList(tx, ty, GameScene.objects)
        if isFreeTileFromObjects == false then return false end
        
        local isFreeTileFromItems = self:isFreeTileForList(tx, ty, GameScene.items)
        if isFreeTileFromItems == false then return false end

        local isFreeTileFromMobs = self:isFreeTileFromMobs(tx, ty, GameScene.mobs)
        if isFreeTileFromMobs == false then return false end

        return true
    end

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

    ---@param tx number tile x
    ---@param ty number tile y
    ---@param mobs Mob[]
    ---@return boolean
    function obj:isFreeTileFromMobs(tx, ty, mobs)
        for i, mob in ipairs(mobs) do
            local mobTX = math.floor((mob.x - GameScene.PX) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))
            
            if mobTX ~= tx then
                break
            end

            local mobTY = math.floor((mob.y - GameScene.PY) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE))

            if mobTX ~= tx then
                break
            end

            return false
        end

        return true
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end