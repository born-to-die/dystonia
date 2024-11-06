BeaconItem = {};

function BeaconItem:create()

    local obj = InventoryItem:create()

    -- Properties

    obj.name = "Beacon"

    -- Methods

    -- Magic

    setmetatable(obj, self)

    return obj
end