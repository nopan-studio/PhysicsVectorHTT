--[[
    Create new Groups
    var ex = __Simply.new_group({
        params.name = name,
        params.isVisible = true,
        params.x = x,
        params.y = y,
        params.w = w,
        params.h = h,
        params.func = funcion() end,
        params.image = image,
        params.group = group,
        params.style = style,## use only if params.image is not used or nil.
        
    })
]]
--## Create new Group
__Simply.new_group = function(params)
    local group = {}
    group.name = params.name 
    group.isVisible = params.isVisible 
    group.x = params.x or error("params.x can't be nil")
    group.y = params.y or error("params.y Can't be nil")
    group.w = params.w or nil
    group.h = params.h or nil
    --## group custom mode
    group.func = params.func or nil
    --##design 
    group.image = params.image or nil
    group.quad = params.quad or nil
    group.style = params.style or nil
    
    table.insert(__Simply.groups,group)
    return group
end

__Simply.group_update = function(comp,dt)
    if comp.func ~= nil then
        comp.func()
    end
end

__Simply.group_draw = function(comp,dt)
    if comp.isVisible then
        if comp.style ~= nil then
            love.graphics.rectangle(comp.style,comp.x,comp.y,comp.w,comp.h)
        elseif comp.image ~= nil and comp.quad == nil then
            love.graphics.draw(comp.image,comp.x,comp.y)
        elseif comp.image ~= nil and comp.quad ~= nil then
            love.graphics.draw(comp.image,comp.quad,comp.x,comp.y)
        end
    end
end