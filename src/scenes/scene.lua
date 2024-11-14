Scene = {}

function Scene:create()

    print("Method 'create' of 'Scene' called")

    local obj = {}

    -- Properties

    obj.isInit = false

    -- Methods

    -- Magic

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function Scene:init()
    if self.isInit then
       return
    end

    self:load()

    self.isInit = true
end

function Scene:load()
    -- need init in childs
end

function Scene:update()
   -- need init in childs
   print("Method 'update' of 'Scene' called")
end

function Scene:render()
   -- need init in childs
   print("Method 'render' of 'Scene' called")
end

function Scene:keypressed()
    -- need init in childs
   print("Method 'keypressed' of 'Scene' called")
end

function Scene:wheelmoved()
    -- need init in childs
   print("Method 'wheelmoved' of 'Scene' called")
end
