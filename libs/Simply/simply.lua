--## LOAD OR INITS
__Simply.load = function()
    __Simply.buttons = {}
    __Simply.groups  = {}
end

--## UPDATES COMPONENT 
__Simply.update = function(dt)
    --## GROUPS
    for ii,comp in ipairs(__Simply.groups) do   
        __Simply.group_update(comp,dt) --## BUTTON
    end
    --## BUTTONS
    for ii,comp in ipairs(__Simply.buttons) do
        __Simply.button_update(comp,dt) --## BUTTON
    end
end

--## DRAW COMPONENT
__Simply.draw = function()
    --## GROUPS
    for ii,comp in ipairs(__Simply.groups) do
        __Simply.group_draw(comp) --## BUTTON   
    end
    --## BUTTONS
    for ii,comp in ipairs(__Simply.buttons) do
        __Simply.button_draw(comp) --## BUTTON
    end
end 

--## MOUSEPRESSES
__Simply.mousepressed = function(x,y,button)
    for ii,comp in ipairs(__Simply.buttons) do
        if button == 1 then
            __Simply.button_pressed(comp,x,y)  
        end
    end
end

__Simply.mousereleased = function(x,y,button)
    for ii,comp in ipairs(__Simply.buttons) do
        if button == 1 then
            __Simply.button_released(comp,x,y)  
        end
    end
end

--## function to reset tables.
__Simply.pop = function(params)
    if params.buttons == false or params.buttons == nil or params.all then
        __Simply.buttons = {}
    end

    if params.groups == false or params.groups == nil or params.all then 
        __Simply.groups = {}
    end
end

