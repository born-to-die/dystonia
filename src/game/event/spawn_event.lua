---@class SpawnEvent
---@field update fun()
SpawnEvent = {}

function SpawnEvent:create()

    local obj = {}
    obj.timer = nil
    obj.repeatTime = 1
    obj.tileChecker = TileChecker:create()
    obj.mathService = MathService:create()

    ---@param walls Wall[]
    ---@param player Player
    ---@param objects Object[]
    function obj.init(walls, player, objects)

        obj.randomAction = function()
            local r = math.random(40)

            if r >= 1 and r <= 4 then
                obj.deleteWall()
            elseif r == 3 then
                obj.createCrate()
            else
                obj.createWall()
            end
        end

        obj.deleteWall = function()
            local selectedWall = math.random(#walls)
            table.remove(walls, selectedWall)
        end

        obj.createWall = function()
            for i = 1, 100, 1 do
                local wx = math.random(10) - 1
                local wy = math.random(10) - 1

                local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)
                local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)
                local isNoCloseToObjects = true
                
                for i = 1, #objects do
                    local dw = obj.mathService:distanceTiles(wx, wy, objects[i].worldX, objects[i].worldY)

                    if dw < 3.2 then
                        isNoCloseToObjects = false
                    end
                end


                if isFreeFromWalls and isFreeFromPlayer and isNoCloseToObjects then
                    table.insert(walls, Wall:create(wx, wy, GameScene.PX, GameScene.PY, GameScene.SX, GameScene.SY))
                    break
                end
            end
        end

        obj.createCrate = function()
            for i = 1, 100, 1 do
                local wx = math.random(10) - 1
                local wy = math.random(10) - 1

                local isFreeFromWalls = obj.tileChecker:isFreeTileForList(wx, wy, walls)
                local isFreeFromPlayer = obj.tileChecker:isFreeTileForObject(wx, wy, player)

                if isFreeFromWalls and isFreeFromPlayer then
                    table.insert(objects, CrateObject:create(wx, wy))
                    break
                end
            end
        end

        obj.timer = TIMER(obj.repeatTime, obj.randomAction)
    end

  
    
    function obj.update()
        if not obj.timer.isExpired() then
            obj.timer.update(GameScene.DT)
        else
            obj.timer = TIMER(obj.repeatTime, obj.randomAction)
        end
    end

  setmetatable(obj, self)
    self.__index = self

    return obj
end