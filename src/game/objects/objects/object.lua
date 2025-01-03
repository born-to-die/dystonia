---@class Object
---@field worldX number
---@field worldY number
---@field sprite table
---@field type string
---@field items MapItem[]
---@field activate fun(self) called when the player activates object
Object = {}

Object.PLAYER_ACTIVITY_TYPE = 'player-activity'
Object.PASSIVE_ACTIVITY_TYPE = 'passive-activity'

---@param worldX number
---@param worldY number
---@param items MapItem[]
---@return table
function Object:create(worldX, worldY, items)

    local obj = {}

    -- Properties

    obj.name = "name"
    obj.x = worldX * GFX_TILE_SIZE_PX * GameScene.SX + GameScene.PX
    obj.y = worldY * GFX_TILE_SIZE_PX * GameScene.SY + GameScene.PY
    obj.worldX = worldX
    obj.worldY = worldY
    obj.sprite = nil
    obj.type = nil
    obj.items = items

    -- Methods

    ---@return table
    function obj:getSprite()
        return obj.sprite
    end

    function obj:activate()
        -- actions
    end

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end