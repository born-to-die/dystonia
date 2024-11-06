SpawnEvent = {}

function SpawnEvent:create()

    local obj = {}
    obj.timer = nil
    obj.repeatTime = 0.1
    obj.tileChecker = TileChecker:create()

    -- @param Wall[] walls
    -- @param Player player
    function obj.init(walls, player)

        obj.callbackFunction = function()
            for i = 1, 100, 1 do
                local wx = math.random(10) - 1
                local wy = math.random(10) - 1

                local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)
                local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)

                if isFreeFromWalls and isFreeFromPlayer then
                    table.insert(walls, Wall:create(wx, wy, GameScene.PX, GameScene.PY, GameScene.SX, GameScene.SY))
                    break
                end
            end
        end

        obj.timer = TIMER(obj.repeatTime, obj.callbackFunction)
    end

  
    
    function obj.update()
        if not obj.timer.isExpired() then
            obj.timer.update(GameScene.DT)
        else
            obj.timer = TIMER(obj.repeatTime, obj.callbackFunction)
        end
    end

  setmetatable(obj, self)
    self.__index = self

    return obj
end