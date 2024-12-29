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

require("src.entities.vector")
require("src.game.control.playerControl")
require("src.game.event.crate_spawner_event")
require("src.game.event.event_abstract")
require("src.game.event.spawn_event")
require("src.game.event.mushrooms_spawner_event")
require("src.game.event.wall_spawner_event")
require("src.game.inventory.inventory")
require("src.game.inventory.inventory_item")
require("src.game.mobs.behaviors.behavior")
require("src.game.mobs.behaviors.DivisionBehavior")
require("src.game.mobs.behaviors.MoveRandomlyBehavior")
require("src.game.mobs.mob")
require("src.game.mobs.slime_mob")
require("src.game.inventory.beacon_item")
require("src.game.inventory.canned_item")
require("src.game.inventory.inventory_item_type")
require("src.game.objects.items.beacon_map_item")
require("src.game.objects.items.canned_map_item")
require("src.game.objects.items.map_item")
require("src.game.objects.objects.object")
require("src.game.objects.objects.beacon_object")
require("src.game.objects.objects.blue_mushrooms_object")
require("src.game.objects.objects.crate_object")
require("src.game.objects.walls.wall")
require("src.game.player.player")
require("src.game.render.backgroundRender")
require("src.game.render.inventory_render")
require("src.game.render.items_render")
require("src.game.render.mobs_render")
require("src.game.render.objects_render")
require("src.game.render.playerRender")
require("src.game.render.wallRender")
require("src.game.utils.collisionChecker")
require("src.game.utils.math_service")
require("src.game.utils.tile_checker")
require("src.scenes.scene")
require("src.scenes.scene_game")
require("src.utils.timer")

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

function love.keypressed(key, scancode, isrepeat)
    currentScene:keypressed(key)
end

function love.wheelmoved(x, y)
    currentScene:wheelmoved(x, y)
end