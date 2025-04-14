---@class Bfs
Bfs = {}
Bfs.__index = Bfs

---@return Vector
function Bfs:findPath(startX, startY, goalX, goalY)
    local width, height = 10, 10
    local visited = {}
    local cameFrom = {}
    local queue = {}

    table.insert(queue, {x = startX, y = startY})
    visited[startY * width + startX] = true

    local directions = {
        {x = 0, y = -1}, -- вверх
        {x = 1, y = 0},  -- вправо
        {x = 0, y = 1},  -- вниз
        {x = -1, y = 0}, -- влево
    }

    while #queue > 0 do
        local current = table.remove(queue, 1)

        if current.x == goalX and current.y == goalY then
            -- Восстановление пути (назад)
            local path = {}
            local key = goalY * width + goalX
            while key do
                local pos = cameFrom[key]
                if pos then table.insert(path, 1, pos) end
                key = pos and (pos.y * width + pos.x) or nil
            end

            -- Если путь найден и длина > 0, вернуть направление от моба к первому шагу
            if #path > 0 then
                local next = path[2]
                return Vector:create(next.x - startX, next.y - startY, 50)
            end
            return Vector:create(0, 0, 50) -- Уже на цели
        end

        for _, dir in ipairs(directions) do
            local nx, ny = current.x + dir.x, current.y + dir.y
            local index = ny * width + nx

            if 
                nx >= 0
                and nx < width
                and ny >= 0
                and ny < height
                and GameScene.wallsService.tailMap[ny]
                and GameScene.wallsService.tailMap[ny][nx] == 0
                and not visited[index]
            then
                visited[index] = true
                cameFrom[index] = {x = current.x, y = current.y}
                table.insert(queue, {x = nx, y = ny})
            end
        end
    end

    return Vector:create(0, 0, 50) -- Путь не найден, стоять на месте
end

