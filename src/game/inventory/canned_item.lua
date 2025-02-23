CannedItem = {};

function CannedItem:create()

    local obj = InventoryItem:create()

    -- Properties

    obj.name = "Canned food"
    obj.desc = "Canned meat, although I don't know what kind of meat it is"
    obj.sprite = love.graphics.newImage("gfx/canned_map_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.type = InventoryItemType.USE

    -- Methods

    ---@overload fun(worldX:number, worldY:number): nil
    function obj:getMapItem(worldX, worldY)
        return CannedMapItem:create(worldX, worldY)
    end

    ---@param player Player
    function obj:use(player)
        player:food(6)
        player:heal(3)
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end