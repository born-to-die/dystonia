if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

GFX_TILE_SIZE_PX = 64
GFX_DEFAULT_SCALE_IMAGE = 1
GFX_DEFAULT_IMAGE_FILTER = "nearest"
GFX_RESOLUTION_W = 1280
GFX_RESOLUTION_H = 720
DEBUG_RENDER = true

PC_UP = 'w'
PC_RIGHT = 'd'
PC_LEFT = 'a'
PC_DOWN = 's'
PC_ACTION = 'space'

function Extended (child, parent)
    setmetatable(child,{__index = parent})
end

dofile("src/entities/vector.lua")
dofile("src/game/control/playerControl.lua")
dofile("src/game/event/spawn_event.lua")
dofile("src/game/inventory/inventory.lua")
dofile("src/game/inventory/inventory_item.lua")
dofile("src/game/inventory/beacon_item.lua")
dofile("src/game/objects/items/beacon_map_item.lua")
dofile("src/game/objects/items/map_item.lua")
dofile("src/game/objects/walls/wall.lua")
dofile("src/game/player/player.lua")
dofile("src/game/render/backgroundRender.lua")
dofile("src/game/render/inventory_render.lua")
dofile("src/game/render/items_render.lua")
dofile("src/game/render/playerRender.lua")
dofile("src/game/render/wallRender.lua")
dofile("src/game/utils/collisionChecker.lua")
dofile("src/game/utils/tile_checker.lua")
dofile("src/scenes/scene.lua")
dofile("src/scenes/scene_game.lua")
dofile("src/utils/timer.lua")

gameScene = GameScene:create()
gameScene:init()

currentScene = gameScene

function love.load()
    love.window.setMode(GFX_RESOLUTION_W, GFX_RESOLUTION_H)
end

function love.update()
    currentScene:init()
    currentScene:update()
end

function love.draw()
    currentScene:render()
end