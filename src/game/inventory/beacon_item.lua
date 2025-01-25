BeaconItem = {};

function BeaconItem:create()

    local obj = InventoryItem:create()

    -- Properties

    obj.name = "Torch"
    obj.desc = "It seems like it's preventing the environment from changing?"
    obj.sprite = love.graphics.newImage("gfx/beacon_map_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.type = InventoryItemType.OBJECT

    -- Methods

    ---@overload fun(worldX:number, worldY:number): nil
    function obj:getMapItem(worldX, worldY)
        return BeaconMapItem:create(worldX, worldY)
    end

    ---@overload fun()
    function obj:getObject(worldX, worldY)
        return BeaconObject:create(worldX, worldY)
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end