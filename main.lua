if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end


GFX_DEFAULT_SCALE_IMAGE = 4
GFX_DEFAULT_IMAGE_FILTER = "nearest"
DEBUG_RENDER = true

function Extended (child, parent)
    setmetatable(child,{__index = parent})
end

dofile("src/entities/vector.lua")
dofile("src/game/control/playerControl.lua")
dofile("src/game/objects/walls/wall.lua")
dofile("src/game/player/player.lua")
dofile("src/game/render/backgroundRender.lua")
dofile("src/game/render/playerRender.lua")
dofile("src/game/utils/collisionChecker.lua")
dofile("src/scenes/scene.lua")
dofile("src/scenes/scene_game.lua")

gameScene = GameScene:create()
gameScene:init()

currentScene = gameScene

function love.load()
    love.window.setMode(1280, 720)
end

function love.update()
    currentScene:init()
    currentScene:update()
end

function love.draw()
    currentScene:render()
end