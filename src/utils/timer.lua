-- @param time int
-- @param callback function
function TIMER(time, callback)
    local expired = false
    local timer = {}
    
    -- @param dt float delta time
    function timer.update(dt)
         if time < 0 then
               expired = true
               callback()
         end
         time = time - dt
    end
  
    -- @return bool 
    function timer.isExpired()
        return expired
    end
  
    return timer
  end