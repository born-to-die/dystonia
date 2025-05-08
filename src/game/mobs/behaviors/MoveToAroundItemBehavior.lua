---@class MoveToAroundItem : Behavior
---@field mapItems MapItem[]
MoveToAroundItem = setmetatable({}, Behavior)
MoveToAroundItem.__index = MoveToAroundItem

---@param mob Mob
---@param mapItems MapItem[]
function MoveToAroundItem:new(mob, mapItems)

    local obj = {}

    obj.name = "MoveToAroundItem"
    obj.mob = mob
    obj.mapItems = mapItems
    obj.aroundItemPosition = {x = nil, y = nil, d = nil}

    obj.call = function ()
      obj:execute()
    end

    obj.timer = TIMER(2, obj.call)

    return setmetatable(obj, self)
end

---@return boolean
function MoveToAroundItem:canExecute()

  for i, mapItem in ipairs(GameScene.items) do

    local distance = MathService:distance(self.mob, mapItem)

    if
      distance < 160
      and mapItem.name == BlueMushroomMapItem.name
    then

      local tx1 = math.floor((self.mob.x - GameScene.PX) / GFX_TILE_SIZE_PX)
      local ty1 = math.floor((self.mob.y - GameScene.PY) / GFX_TILE_SIZE_PX)
      local tx2 = mapItem.worldX
      local ty2 = mapItem.worldY
      
      local isVisible = TileRaycast:isVisible(tx1, ty1, tx2, ty2)

      if isVisible == false then
        goto continue
      end

      if (self.aroundItemPosition.d == nil or distance < self.aroundItemPosition.d) then
        self.aroundItemPosition = {
          x = mapItem.x,
          y = mapItem.y,
          i = mapItem,
          d = distance,
        }
      end
    end
      ::continue::
  end

  if self.aroundItemPosition.d ~= nil then
    return true
  end

  return false
end

function MoveToAroundItem:execute()

  if (self.aroundItemPosition.i.deleted == true) then
    self.aroundItemPosition = {x = nil, y = nil, d = nil, i = nil}
    return
  end

  local distance = MathService:distance(self.mob, self.aroundItemPosition)

  if (distance < GFX_TILE_SIZE_PX / 4) then
    self.aroundItemPosition = {x = nil, y = nil, d = nil}
    return
  end

  self.mob.vector = Bfs:findPath(
      math.floor((self.mob.x - GameScene.PX) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
      math.floor((self.mob.y - GameScene.PY) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
      math.floor((self.aroundItemPosition.x - GameScene.PX) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
      math.floor((self.aroundItemPosition.y - GameScene.PY) / (GFX_TILE_SIZE_PX * GFX_DEFAULT_SCALE_IMAGE)),
      self.mob
    )
end
