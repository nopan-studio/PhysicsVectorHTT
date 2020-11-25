htt = {}

function htt:load()

    cx,cy = 1980/4 * -1,1980/3 * -1
    scale = 0.8
    canvasSize = {1980,1980}
    ww, wh = love.graphics.getDimensions()
    canvas = love.graphics.newCanvas(canvasSize[1],canvasSize[2])
    startingX, startingY = canvasSize[1]/2,canvasSize[2]/2
    cx,cy = startingX  * -1 + 500,startingY * -1 + 500
    convertLen = 25 --len to px for scaling
    getResultant = true

    for i, vector in ipairs(vectors) do

        if i ~= 1 then
            vector.x = vectors[i-1].tx
            vector.y = vectors[i-1].ty
        else
            vector.x = startingX
            vector.y = startingY
        end

        if i ~= #vectors then
            vector.length = vector.length * convertLen
            vector.angle = vector.angle * math.pi / 180

            if vector.direction == "N" then
                vector.tx = vector.x
                vector.ty = vector.y - vector.length

            elseif vector.direction == "S" then
                vector.tx = vector.x

                vector.ty = vector.y + vector.length
            elseif vector.direction == "E" then
                vector.tx = vector.x + vector.length 
                vector.ty = vector.y

            elseif vector.direction == "W" then
                vector.tx = vector.x - vector.length 
                vector.ty = vector.y

            elseif vector.direction == "NoE"then
                vector.tx = vector.x + vector.length * math.cos(vector.angle)
                vector.ty = vector.y - vector.length * math.sin(vector.angle)
            
            elseif vector.direction == "EoN"   then
                vector.tx = vector.x + vector.length * math.cos((90 * math.pi/180)-vector.angle)
                vector.ty = vector.y - vector.length * math.sin((90 * math.pi/180)-vector.angle)

            elseif vector.direction == "NoW" then
                vector.tx = vector.x - vector.length * math.cos(vector.angle)
                vector.ty = vector.y - vector.length * math.sin(vector.angle)

            elseif vector.direction == "WoN" then
                vector.tx = vector.x - vector.length * math.cos((90 * math.pi/180)-vector.angle)
                vector.ty = vector.y - vector.length * math.sin((90 * math.pi/180)-vector.angle)

            elseif vector.direction == "SoE" then
                vector.tx = vector.x + vector.length * math.cos(vector.angle)
                vector.ty = vector.y + vector.length * math.sin(vector.angle)
            
            elseif  vector.direction == "EoS" then
                vector.tx = vector.x + vector.length * math.cos((90 * math.pi/180)-vector.angle)
                vector.ty = vector.y + vector.length * math.sin((90 * math.pi/180)-vector.angle)

            elseif vector.direction == "SoW" then
                vector.tx = vector.x - vector.length * math.cos(vector.angle)
                vector.ty = vector.y + vector.length * math.sin(vector.angle)

            elseif vector.direction == "WoS" then
                vector.tx = vector.x - vector.length * math.cos((90 * math.pi/180)-vector.angle)
                vector.ty = vector.y + vector.length * math.sin((90 * math.pi/180)-vector.angle)

            else
                error("direction is unknown, please check your direction in Vector :"..vector.name)
            end
        else
            vector.tx = vectors[1].x
            vector.ty = vectors[1].y 
            vector.length = htt:round(math.sqrt((vectors[1].y - vector.y)^2+(vectors[1].x - vector.x)^2) / convertLen,2)
            vector.direction = {}
            vector.angle = {}
            if vector.x == vectors[1].x and vector.y < vectors[1].y then
                
                vector.direction[1] = "N"
                vector.angle[1] = 90

            elseif vector.x == vectors[1].x and vector.y > vectors[1].y then

                vector.direction[1] = "S"
                vector.angle[1] = 90

            elseif vector.x > vectors[1].x and vector.y == vectors[1].y then

                vector.direction[1] = "E"
                vector.angle[1] = 0

            elseif vector.x < vectors[1].x and vector.y == vectors[1].y then

                vector.direction[1] = "W"
                vector.angle[1] = 0

            elseif vector.x < vectors[1].x and vector.y < vectors[1].y then

                vector.direction[1] = "NoW"
                vector.direction[2] = "WoN"
                vector.angle[1] = math.abs(math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * 180 / math.pi )
                vector.angle[2] = math.abs(90 - vector.angle[1])

            elseif vector.x < vectors[1].x and vector.y > vectors[1].y then

                vector.direction[1] = "SoW"
                vector.direction[2] = "WoS"
                vector.angle[1] = math.abs((math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x)) * 180 / math.pi )
                vector.angle[2] = math.abs(90 - vector.angle[1])
            
            elseif vector.x > vectors[1].x and vector.y < vectors[1].y then

                vector.direction[1] = "NoE"
                vector.direction[2] = "EoN"
                vector.angle[1] = math.abs(math.atan2(vector.y - vectors[1].y, vector.x - vectors[1].x) * 180 / math.pi )
                vector.angle[2] = math.abs(90 - vector.angle[1])

            elseif vector.x > vectors[1].x and vector.y > vectors[1].y then

                vector.direction[1] = "SoE"
                vector.direction[2] = "EoS"
                vector.angle[1] = math.abs(math.atan2(vector.y - vectors[1].y, vector.x - vectors[1].x) * 180 / math.pi )
                vector.angle[2] = math.abs(90 - vector.angle[1])

            end
        end
    end
end

function htt:update(dt)
    local lkd = love.keyboard.isDown
    if lkd("q") then
        cx = cx - 120 * dt
        cy = cy - 120 * dt
        scale = scale + 0.005
        
    end

    if lkd("a") and scale >= 0.5 then
        cx = cx + 120 * dt
        cy = cy + 120 * dt
        scale = scale - 0.005
        
    end

    if lkd("left") then
        cx = cx - 80 * dt
    end
    if lkd("right")then
        cx = cx + 80 * dt
    end
    if lkd("up")  then
        cy = cy - 80 * dt
    end
    if lkd("down") then
        cy = cy + 80 * dt
    end
end

function htt:draw()
    local startX, startY = 60, 50
    local gap = 20

    love.graphics.setCanvas(canvas)
    love.graphics.clear()

    for i, vector in ipairs(vectors) do
        if i ~= #vectors then
            htt:drawVector(vector)
            --love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)
            

        elseif i== #vectors and getResultant == true then
            htt:plane(vector)
            love.graphics.setColor(0.8,0.3,0.3)
            love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)
            love.graphics.setColor(1,1,1)
        
        end
    end

    love.graphics.setCanvas()
    love.graphics.draw(canvas,cx,cy,0,scale,scale)
    --
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("fill",0,0,50,1000)
    love.graphics.rectangle("fill",0,0,1000,50)
    love.graphics.rectangle("fill",ww-50,0,50,1000)
    love.graphics.rectangle("fill",0,wh/1.3,1000,1000)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line",50,50,700,415)
    --
    love.graphics.print("Vectors :",startX,startY+10)

    for i, vector in ipairs(vectors) do
        if i ~= #vectors then
                -- love.graphics.line( startX, startY+(gap*i),startX + 300,startY+(gap*i))
                love.graphics.print(vector.name.." = "..htt:reverse(vector.length,"length").." , "..htt:reverse(vector.angle,"angle").."°, "..vector.direction,
                                    startX, startY+(gap*i)+15)
        
        else
            love.graphics.print("Resultant Contents :",startX,wh - 120)
            if #vector.angle == 2 then
                love.graphics.print("θ°\t\t\tdirection \n\n"..htt:round(vector.angle[1],2).."° \t\t"..vector.direction[1].."\n\n"..htt:round(vector.angle[2],2).."° \t\t"..vector.direction[2],
                            startX,wh - 90)

                love.graphics.print("length\n\n"..htt:round(vector.length,2),
                            startX+gap*8,wh - 90)

                love.graphics.print(vector.name.." = "..vector.length.." at "..htt:round(vector.angle[1],2).."°,"..vector.direction[1].." or \n\n\t\t"..vector.length.." at "..htt:round(vector.angle[2],2).."°,"..vector.direction[2],
                startX+gap*12 ,wh - 90)

            else
                love.graphics.print("θ°\t\t\tdirection \n\n"..htt:round(vector.angle[1],2).."° \t\t"..vector.direction[1],
                            startX,wh - 90)
                
                love.graphics.print("length\n\n"..htt:round(vector.length,2),
                            startX+gap*8,wh - 90)
                            
                love.graphics.print(vector.name.." = "..vector.length.." at "..htt:round(vector.angle[1],2).."°,"..vector.direction[1],
                startX+gap*12 ,wh - 90)

            end
        end
    end

    love.graphics.print("Commands :\nuse arrow keys to \nmove the canvas \n\"q\" to upscale \n\"a\" to downscale",
    startX+gap*28,wh - 120)

    love.graphics.print("GRAPHICAL METHOD",
                        ww/3+50,20)
end

function htt:drawVector(vector)
    htt:plane(vector)
    love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)

    local dir = vector.direction
    local angle = vector.angle

end

function htt:round(number, precision)
    local fmtStr = string.format('%%0.%sf',precision)
    number = string.format(fmtStr,number)
    return number
 end

function htt:reverse( n, flag)
    if flag == "length" then
        n = n / convertLen 
    elseif flag == "angle" then
        n = n * 180 / math.pi 
    end
    return n 
end

function htt:degtorad(d)
    return d * math.pi / 180
end

function htt:getAngleThingy(name,x,y,dir,angleIndcicatorSize,angle)
   if name == "R" then  love.graphics.setColor(0.8,0.3,0.3) end -- paint it red.

    if dir == "S" then -- not neccesary
        --love.graphics.arc("line",x,y,20,0,htt:degtorad(90))
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end

        love.graphics.print(name,
                            x - 20,y - 20)

    elseif dir == "W" then -- not neccesary
        --love.graphics.arc("line",x,y,20,htt:degtorad(180),htt:degtorad(270))
       
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x + 5,y + 5)
       
    elseif dir == "E" then -- not neccesary
        --love.graphics.arc("line",x,y,20,htt:degtorad(360),htt:degtorad(270))
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x - 20,y + 5)

    elseif dir == "N" then -- not neccesary
        --love.graphics.arc("line",x,y,20,htt:degtorad(360),htt:degtorad(270))
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x - 20,y + 5)

    elseif dir == "SoE" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,0,angle)

        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x - 20,y - 20)

    elseif dir == "EoS" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(90),htt:degtorad(90) - angle)
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end

        love.graphics.print(name,
                            x - 20,y - 20)

    elseif dir == "SoW" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(180),htt:degtorad(180) - angle)
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end

        love.graphics.print(name,
                            x + 5,y - 20)

    elseif dir == "WoS" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(90),htt:degtorad(90) + angle)

        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x + 5,y - 20)

    elseif dir == "WoN" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(270),htt:degtorad(270) - angle)
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x + 5,y - 20)

    elseif dir == "NoW" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(180),htt:degtorad(180) + angle)
        
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
        end
        love.graphics.print(name,
                            x + 5,y + 5)
    
    elseif dir == "NoE" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,0,-angle)

        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
           end

        love.graphics.print(name,
                            x - 20,y + 5)

    elseif dir == "EoN" then
        love.graphics.arc("line",x,y,angleIndcicatorSize,htt:degtorad(270), htt:degtorad(270)+angle)
       
        if name == "R" then
            x,y = vectors[#vectors].x, vectors[#vectors].y
           end

        love.graphics.print(name,
                            x - 20,y + 5)
    end

    love.graphics.setColor(1,1,1)
end

function htt:plane(vector)

    local x,y = vector.x,vector.y
    local angle = vector.angle
    local angleIndcicatorSize = 23 
    local dir = vector.direction
    local length = 30

    --love.graphics.setColor(0.6,0.6,0.6)
    love.graphics.line(x,y-length,x,y+length)
    love.graphics.line(x-length,y,x+length,y)
    love.graphics.setColor(1,1,1)
   
    if vector.name == "R" then
        htt:getAngleThingy(vector.name,vector.tx,vector.ty,dir[1],angleIndcicatorSize,htt:degtorad(angle[1]))
    else
        htt:getAngleThingy(vector.name,x,y,dir,angleIndcicatorSize,angle)
    end  
    
end