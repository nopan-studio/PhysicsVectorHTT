--[[
    ##how to add button##
    button_name = __Simply.button_add([
        name = "name",
        group = "group_name",
        isVisible = true/false,
        setVisibility = true/false, determines if auto visibility check is allowed.
        x = int,
        y = int,
        w = int,
        h = int,
        pressed = function ()
            end,
        image = nil,
        quad = nil,
    ])
]]

--## ADD BUTTON
__Simply.new_button = function(params)
    local button = {
        name = params.name or error("params.name can't be nil"),
        group = params.group or nil,
        isVisible = params.isVisible,
        setVisibility = params.setVisibility,
        x = params.x or error("params.x can't be nil"),
        y = params.y or error("params.y can't be nil"),
        w = params.w or error("params.w can't be nil"),
        h = params.h or error("params.h can't be nil"),
        pressed = params.pressed or nil,
        released = params.released or nil,
        image = params.image or nil,
        image_2 = params.image_2 or nil,
        activeimage = params.image or nil,
        quad = params.quad or nil,
        update = params.update or nil,
        alpha = params.alpha or 1,
    }
    table.insert(__Simply.buttons,button)
    return button
end

--## UPDATE BUTTON
__Simply.button_update = function(comp,dt)
    --call update of the button for animation
    if comp.update ~= nil then
        comp.update(comp,dt)
    end
    --
    if comp.group ~= nil and comp.setVisibility == true then 
        for ii, group in ipairs(__Simply.groups) do
            if comp.group == group.name then
                comp.isVisible = group.isVisible
            end
        end
    end
end

--## DRAW BUTTON
__Simply.button_draw = function(comp)
    if  comp.isVisible then
        if comp.image ~= nil and comp.quad ~= nil then
            love.graphics.setColor(1,1,1)
            
            love.graphics.draw(comp.image,comp.quad,comp.x,comp.y)
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill",comp.x,comp.y,comp.w,comp.h,5,5)
            love.graphics.setColor(1,1,1)
        elseif comp.image ~= nil and comp.quad == nil then
            love.graphics.setColor(1,1,1,comp.alpha)
                love.graphics.draw(comp.activeimage,comp.x,comp.y,0,1,1)
                --love.graphics.setColor(0,0,0)
                --love.graphics.rectangle("line",comp.x,comp.y,comp.w,comp.h,5,5)
            love.graphics.setColor(1,1,1)
        else
            love.graphics.setColor(1,1,1)
            love.graphics.rectangle("line",comp.x,comp.y,comp.w,comp.h)
            love.graphics.print(comp.name,comp.x + 5,comp.y + comp.h/3)
        end
    end
end

__Simply.button_pressed = function(comp,x,y)
    if comp.isVisible and __Simply.aabb({x=x,y=y,w=1,h=1},{x=comp.x,y=comp.y,w=comp.w,h=comp.h}) and comp.pressed ~= nil then
        if comp.image_2 ~= nil then
            comp.activeimage = comp.image_2
        end
        --
        comp.pressed()
    end 
end

__Simply.button_released = function(comp,x,y)
    if comp.image ~= nil then
        comp.activeimage = comp.image
    end
    --
    if comp.isVisible and __Simply.aabb({x=x,y=y,w=1,h=1},{x=comp.x,y=comp.y,w=comp.w,h=comp.h}) and comp.released ~= nil then
        comp.released()
    end 
end


