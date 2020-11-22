htt = {}

function htt:round(number, precision)
    local fmtStr = string.format('%%0.%sf',precision)
    number = string.format(fmtStr,number)
    return number
 end

function htt:load()

    cx,cy = 10,10
    ww, wh = love.graphics.getDimensions()
    canvas = love.graphics.newCanvas(800,600)
    startingX, startingY = ww/3,wh/3
    convertLen = 20 --len to px for scaling
    pi = math.pi
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
            elseif vector.direction == "NoE" or vector.direction == "EoN"   then
                vector.tx = vector.x + vector.length * math.cos(vector.angle)
                vector.ty = vector.y - vector.length * math.sin(vector.angle)
            elseif vector.direction == "NoW" or vector.direction == "WoN"   then
                vector.tx = vector.x - vector.length * math.cos(vector.angle)
                vector.ty = vector.y - vector.length * math.sin(vector.angle)
            elseif vector.direction == "SoE" or vector.direction == "EoS"   then
                vector.tx = vector.x + vector.length * math.cos(vector.angle)
                vector.ty = vector.y + vector.length * math.sin(vector.angle)
            elseif vector.direction == "SoW" or vector.direction == "WoS"   then
                vector.tx = vector.x - vector.length * math.cos(vector.angle)
                vector.ty = vector.y + vector.length * math.sin(vector.angle)
            end
        else
            vector.tx = vectors[1].x
            vector.ty = vectors[1].y 
            vector.length =htt:round(math.sqrt((vectors[1].y - vector.y)^2+(vectors[1].x - vector.x)^2) / convertLen,2)

            if vector.x == vectors[1].x and vector.y > vectors[1].y then
                vector.direction = "N"
                vector.angle = 90

            elseif vector.x == vectors[1].x and vector.y < vectors[1].y then
                vector.direction = "S"
                vector.angle = 90

            elseif vector.x > vectors[1].x and vector.y == vectors[1].y then
                vector.direction = "E"
                vector.angle = 0

            elseif vector.x < vectors[1].x and vector.y == vectors[1].y then
                vector.direction = "W"
                vector.angle = 0

            elseif vector.x < vectors[1].x and vector.y < vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "NoW"
                vector.direction[2] = "WoN"
                vector.angle = {}
                vector.angle[1] = math.abs(math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * 180 / pi )
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1

            elseif vector.x < vectors[1].x and vector.y > vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "WoS"
                vector.direction[2] = "SoW"
                vector.angle = {}
                vector.angle[1] = math.abs(math.atan2(vector.y - vectors[1].y, vector.x - vectors[1].x) * 180 / pi )
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1
            
            elseif vector.x > vectors[1].x and vector.y < vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "EoN"
                vector.direction[2] = "NoE"
                vector.angle = {}
                
                
                vector.angle[1] = math.abs(math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * 180 / pi )
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1

            elseif vector.x > vectors[1].x and vector.y > vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "SoE"
                vector.direction[2] = "EoS"
                vector.angle = {}
               
                vector.angle[1] = math.abs(math.atan2(vector.y - vectors[1].y, vector.x - vectors[1].x) * 180 / pi )
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1
            end
        end
    end
end

function htt:update(dt)
    local lkd = love.keyboard.isDown
    if lkd("left") then
        cx = cx - 80 * dt
    end
    if lkd("right") then
        cx = cx + 80 * dt
    end
    if lkd("up") then
        cy = cy - 80 * dt
    end
    if lkd("down") then
        cy = cy + 80 * dt
    end

end

function htt:reverse( n, flag)
    if flag == "length" then
        n = n / convertLen 

    elseif flag == "angle" then
        n = n * 180 / math.pi 
    end

    return n 
end

function htt:draw()
    local startX, startY = 60, 50
    local gap = 20

    love.graphics.setCanvas(canvas)
    love.graphics.clear()
    for i, vector in ipairs(vectors) do
        if i ~= #vectors then
            love.graphics.print(vector.name,
                                vector.x,vector.y - 20)
            love.graphics.circle("line",vector.tx,vector.ty,1)
            love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)

        elseif i== #vectors and getResultant == true then
            love.graphics.print(vector.name, vector.x + 5,vector.y - 15)
            love.graphics.circle("line",vector.tx,vector.ty,1)
            love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)
        
        end
    end
    love.graphics.setCanvas()
    love.graphics.draw(canvas,cx,cy)
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
            else
                love.graphics.print("θ°\t\t\tdirection \n\n"..htt:round(vector.angle,2).."° \t\t"..vector.direction,
                            startX,wh - 90)
            end
            love.graphics.print("length\n\n"..htt:round(vector.length,2),
                        startX+gap*8,wh - 90)
            love.graphics.print(vector.name.." = "..vector.length.." at "..math.floor(vector.angle[1]).."°,"..vector.direction[1].." or \n\n\t\t"..vector.length.." at "..math.floor(vector.angle[2]).."°,"..vector.direction[2],
                startX+gap*12 ,wh - 90)   
        end
    end

    love.graphics.print("Graph Movements :\n\nuse arrow keys to \n\nmove the canvas ",
    startX+gap*28,wh - 120)

    love.graphics.print("GRAPHICAL METHOD",
                        ww/3+50,20)
  
end