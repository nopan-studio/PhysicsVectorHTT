--## HOW TO USE AABB
--[[
    __Simply.aabb({x=1,y=1,w=1,h=1},{x=1,y=1,w=1,h=1})
]]
--## AABB
__Simply.aabb = function(params1,params2)
    if params1.x + params1.w > params2.x and
        params1.y + params1.h > params2.y and 
            params2.x + params2.w > params1.x and
                params2.y + params2.h > params1.y then
                return true --## RETURN TRUE
    end
end