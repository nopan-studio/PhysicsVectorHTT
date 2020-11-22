--## STATES MANAGER
__Simply.state_current = nil
__Simply.state_current_string = nil
__Simply.state_previous = nil

--## STATE FUNCTIONS
__Simply.state_switch = function(to,toStr)
    __Simply.state_previous = __Simply.state_current
    __Simply.state_previous_string = __Simply.state_current_string
    __Simply.state_current = to
    __Simply.state_current_string = toStr
    __Simply.state_current:load()
end

--## UPDATE STATES
__Simply.state_load = function()
    __Simply.state_current:load()
end

__Simply.state_update = function(dt)
    __Simply.state_current:update(dt)
end

__Simply.state_draw = function()
    __Simply.state_current:draw()
end

__Simply.state_mousepressed = function(x,y,button)
    __Simply.state_current:mousepressed(x,y,button)
end

__Simply.state_mousereleased = function(x,y,button)
    __Simply.state_current:mousereleased(x,y,button)
end