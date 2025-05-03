---@class Bfs
Bfs = {}
Bfs.__index = Bfs

---@param startX integer
---@param startY integer
---@param goalX integer
---@param goalY integer
---@param mob Mob
---@return Vector
function Bfs:findPath(startX, startY, goalX, goalY, mob)
    local width, height = GameScene.MAP_TILES_X, GameScene.MAP_TILES_Y
    local tileSizePX = GFX_TILE_SIZE_PX
    local halfTileSizePX = GFX_TILE_HALF_SIZE_PX
    local px = GameScene.PX
    local py = GameScene.PY
    local tileMap = GameScene.wallsService.tailMap;

    local visited = {}
    local cameFrom = {}
    local queue = {{x = startX, y = startY}}

    visited[startY * width + startX] = true

    local directions = {
        {x = 0, y = -1},
        {x = 1, y = 0},
        {x = 0, y = 1},
        {x = -1, y = 0},
    }

    while #queue > 0 do
        local current = table.remove(queue, 1)

        --- Resurrection of the path
        if current.x == goalX and current.y == goalY then
            local path = {}
            local key = goalY * width + goalX

            table.insert(path, 1, {x = current.x, y = current.y})

            while key do
                local pos = cameFrom[key]
                if pos then table.insert(path, 1, pos) end
                key = pos and (pos.y * width + pos.x) or nil
            end

            if #path > 0 then
                local next = path[2] or path[1]

                local tx = next.x * tileSizePX + px + halfTileSizePX
                local ty = next.y * tileSizePX + py + halfTileSizePX

                return Vector:create(tx - mob.x, ty - mob.y, mob.speed)
            end
            return Vector:create(0, 0, 0)
        end

        --- Fill
        for _, dir in ipairs(directions) do
            local nx, ny = current.x + dir.x, current.y + dir.y
            local index = ny * width + nx

            if 
                nx >= 0
                and nx < width
                and ny >= 0
                and ny < height
                and tileMap[ny + 1]
                and tileMap[ny + 1][nx + 1] == 0
                and not visited[index]
            then
                visited[index] = true
                cameFrom[index] = {x = current.x, y = current.y}
                table.insert(queue, {x = nx, y = ny})
            end
        end
    end

    return Vector:create(0, 0, 0)
end

