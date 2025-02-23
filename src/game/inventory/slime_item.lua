---@class SlimeItem : InventoryItem
SlimeItem = {};

function SlimeItem:create()

    local obj = InventoryItem:create()

    -- Properties

    obj.name = "Disgusting slime"
    obj.desc = "Despite its foul smell, it seems quite edible."
    obj.sprite = love.graphics.newImage("gfx/slime_item.png")
    obj.sprite:setFilter(GFX_DEFAULT_IMAGE_FILTER)
    obj.type = InventoryItemType.USE

    -- Methods
    
    function obj:getMapItem(worldX, worldY)
        return SlimeMapItem:create(worldX, worldY)
    end

    ---@param player Player
    function obj:use(player)
        player:food(3)
        player:heal(5)
    end

    -- Magic

    setmetatable(obj, self)

    return obj
end