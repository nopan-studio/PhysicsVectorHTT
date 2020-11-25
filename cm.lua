cm = {}

function cm:getX(vector)
    local angle 

    if vector.direction == "EoN" or 
        vector.direction == "EoS"   or
            vector.direction == "WoN"   or
                vector.direction == "WoS" then

                 angle = ((90 - vector.angle)* math.pi) / 180
    else
         angle = (vector.angle * math.pi) / 180
    end

    local ret = vector.length*math.cos(angle)

    if vector.direction == "W" or 
         vector.direction == "WoN" or 
            vector.direction == "NoW" or 
                vector.direction == "WoS" or 
                    vector.direction == "SoW" then
                    ret = ret * -1
    end

    cm.sumX = cm.sumX + ret
    return ret

end

function cm:getY(vector)
    local angle
     if vector.direction == "EoN" or 
        vector.direction == "EoS"   or
            vector.direction == "WoN"   or
                vector.direction == "WoS" then

                angle = ((90 - vector.angle)* math.pi) / 180
    else
        
        angle = (vector.angle * math.pi) / 180
    end

    local ret = vector.length*math.sin(angle)

     if vector.direction == "S" or 
         vector.direction == "EoS" or 
            vector.direction == "SoE" or 
                vector.direction == "WoS" or 
                    vector.direction == "SoW" then
                    ret = ret * -1
    end

    cm.sumY = cm.sumY + ret
    return ret
end


function cm:getDirection(x,y)

    local dir

    if x == 0 and y <= 0 then
        dir = {}
        dir[1] = "S"

    elseif x == 0 and y >= 0 then
        dir = {}
        dir[1] = "N"

    elseif x > 0 and y == 0 then
        dir = {}
        dir[1] = "E"

    elseif x < 0 and y == 0 then
        dir = {}
        dir[1] = "W"

    elseif x < 0 and y < 0 then
        dir = {}
        dir[1] = "SoW"
        dir[2] = "WoS"

    elseif x > 0 and y < 0 then
        dir = {}
        dir[1] = "SoE"
        dir[2] = "EoS"
    
    elseif x > 0 and y > 0 then
        dir = {}
        dir[1] = "NoE"
        dir[2] = "EoN"
    
    elseif x < 0 and y > 0 then
        dir = {}
        dir[1] = "NoW"
        dir[2] = "WoN"
     
    end

    return dir
end

function cm:load()
    
    ww, wh = love.graphics.getDimensions()
    cx,cy = 0,0
    canvasSize = {ww,5000}
    canvas = love.graphics.newCanvas(canvasSize[1],canvasSize[2])
    cm.sumX,cm.sumY = 0, 0
    for i, vector in ipairs(vectors) do
        if i ~= #vectors then
            vector.x = cm:getX(vector)
            vector.y = cm:getY(vector)
        else
            vector.x = cm.sumX
            vector.y = cm.sumY
        end
    end

    cm.R = cm:round(math.sqrt((cm.sumX)^2 + (cm.sumY)^2),2)
    cm.angle = cm:round(math.abs(math.atan(cm.sumY/cm.sumX)*180/math.pi),2)
    cm.direction = cm:getDirection(cm.sumX,cm.sumY)
end

function cm:update(dt)
    local lkd = love.keyboard.isDown
 
    if lkd("up") and cy <= 0 then
        cy = cy + 100 * dt
    end
    if lkd("down") then
        cy = cy - 100 * dt
    end
end

function cm:draw()
    local startX, startY = 80, 70
    local gap = 40,
    love.graphics.setCanvas(canvas)
        love.graphics.clear()
        love.graphics.print("n",startX, startY+15)
        love.graphics.print("r",startX+gap, startY+15)
        love.graphics.print("θ",startX+gap*2, startY+15)
        love.graphics.print("direction",startX+gap*3, startY+15)
        love.graphics.print("x",startX+gap*5.2, startY+15)
        love.graphics.print("y",startX+gap*6.77, startY+15)
        --
        love.graphics.line( startX, startY,startX + 300,startY)
        --
        love.graphics.line( startX+gap*4.5, startY+gap,startX+gap*4.5,startY+gap*(#vectors+1))
        love.graphics.line( startX+gap*6.2, startY+gap,startX+gap*6.2,startY+gap*(#vectors+1))
        --
        for i, vector in ipairs(vectors) do
            if i ~= #vectors then
                love.graphics.line( startX, startY+(gap*i),startX + 300,startY+(gap*i))
                love.graphics.print(vector.name,startX, startY+(gap*i)+15)
                love.graphics.print(vector.length,startX + gap, startY+(gap*i)+15)
                love.graphics.print(vector.angle.."°",startX + gap*2, startY+(gap*i)+15)
                love.graphics.print(vector.direction,startX + gap*3, startY+(gap*i)+15)
                love.graphics.print(cm:round(vector.x,2),startX + gap*5, startY+(gap*i)+15)
                love.graphics.print(cm:round(vector.y,2),startX + gap*6.5, startY+(gap*i)+15)
            else
                love.graphics.line( startX, startY+(gap*i),startX + 300,startY+(gap*i))
                --love.graphics.print(vector.name,startX+gap*3, startY+(gap*i)+15)
                love.graphics.print("Σ "..cm:round(vector.x,2),startX + gap*5, startY+(gap*i)+15)
                love.graphics.print("Σ "..cm:round(vector.y,2),startX + gap*6.5, startY+(gap*i)+15)
            end
        end
        --
        love.graphics.print("Solution ",
                            startX+gap*8+10, startY+15)

        love.graphics.print("R = √ "..cm:round(cm.sumX,2).."² + "..cm:round(cm.sumY,2).."² \t θ = atan( "..cm:round(cm.sumX,2).." / "..cm:round(cm.sumY,2).." )",
                            startX+gap*8+10, startY+(gap*1))

        love.graphics.print("R = "..cm.R.."\t θ = "..cm.angle,
                            startX+gap*8+10,startY+(gap*2))

        love.graphics.print("\nFinal Answer :\n\nR ="..cm.R.." at "..cm.angle.."°, "..cm.direction[1],
                            startX+gap*8+10, startY+(gap*3))
                            
    love.graphics.setCanvas()

    love.graphics.draw(canvas,cx,cy)

    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,50,1000)
    love.graphics.rectangle("fill",0,0,1000,50)
    love.graphics.rectangle("fill",ww-50,0,50,1000)
    love.graphics.rectangle("fill",0,wh/1.3,1000,1000)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",50,50,700,415)

    love.graphics.print("Commands :\nuse arrow up/down to scroll the output",
                        50,wh - 120)

    love.graphics.print("COMPONENT METHOD",
                        ww/3+50,20)
end

function cm:round(number, precision)
    local fmtStr = string.format('%%0.%sf',precision)
    number = string.format(fmtStr,number)
    return number
 end

