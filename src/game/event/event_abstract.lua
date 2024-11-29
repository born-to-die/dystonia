---@class EventAbstract
---@field create fun(self: self, walls: Wall[], player: Player, objects: Object[], items: MapItem[]): table
EventAbstract = {}

function EventAbstract:create(walls, player, objects, items)

    local obj = {}

    -- properties

    obj.interval = 5
    obj.chance = 0

    obj.walls = walls
    obj.player = player
    obj.objects = objects
    obj.items = items

    -- variable methods

    obj.check = function ()

      local c = math.random()
      
      if c < obj.chance then
        obj.run()
      end
    end

    obj.timer = TIMER(obj.interval, obj.check)

    -- methods
    
    function obj.update()
      if not obj.timer.isExpired() then
        obj.timer.update(GameScene.DT)
      else
          obj.timer = TIMER(obj.interval, obj.check)
      end
    end

    function obj.run()
      -- your code
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end