function love.load()
    -- startz
    vectors = require "vectors"
    startingX, startingY = 450,430

    convertLen = 20 --len to px for scaling
    converAngle = 180 -- degree to radians
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
            vector.angle = (vector.angle * pi) / 180

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
            vector.length =math.floor(math.sqrt((vectors[1].y - vector.y)^2+(vectors[1].x - vector.x)^2) / convertLen)

            if vector.x == vectors[1].x and vector.y > vectors[1].y then
                vector.direction = "N"
                vector.angle = 0

            elseif vector.x == vectors[1].x and vector.y < vectors[1].y then
                vector.direction = "S"
                vector.angle = 0

            elseif vector.x > vectors[1].x and vector.y == vectors[1].y then
                vector.direction = "E"
                vector.angle = 0

            elseif vector.x < vectors[1].x and vector.y == vectors[1].y then
                vector.direction = "W"
                vector.angle = 0

            elseif vector.x < vectors[1].x and vector.y < vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "WoN"
                vector.direction[2] = "NoW"
                vector.angle = {}
                vector.angle[1] = math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * (180 / pi)
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1

            elseif vector.x < vectors[1].x and vector.y > vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "WoS"
                vector.direction[2] = "SoW"
                vector.angle = {}
                vector.angle[1] = math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * (180 / pi)
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1
            
            elseif vector.x > vectors[1].x and vector.y < vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "EoN"
                vector.direction[2] = "NoE"
                vector.angle = {}
                vector.angle[1] = math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * (180 / pi)
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1

            elseif vector.x > vectors[1].x and vector.y > vectors[1].y then
                vector.direction = {}
                vector.direction[1] = "EoS"
                vector.direction[2] = "SoE"
                vector.angle = {}
                vector.angle[1] = math.atan2(vectors[1].y - vector.y, vectors[1].x - vector.x) * (180 / pi)
                vector.angle[2] = math.abs(90 - vector.angle[1]) + 1
            end
        end
    end

    ww, wh = love.graphics.getDimensions()
    graphCanvas = love.graphics.newCanvas()
end

function love.draw()
    for i, vector in ipairs(vectors) do
        if i ~= #vectors then
            love.graphics.print(vector.angle * 180 / pi.."°,"..vector.direction, vector.x + 25,vector.y - 15)
            love.graphics.print(vector.name, vector.x + 5,vector.y - 15)
            love.graphics.circle("line",vector.tx,vector.ty,1)
            love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)

        elseif i== #vectors and getResultant == true then
            love.graphics.print(math.floor(vector.angle[1]).."°,"..vector.direction[1], vector.x + 20,vector.y - 15)
            love.graphics.print(math.floor(vector.angle[2]).."°,"..vector.direction[2], vector.x + 100,vector.y - 15)
            love.graphics.print(vector.name, vector.x + 5,vector.y - 15)
            love.graphics.circle("line",vector.tx,vector.ty,1)
            love.graphics.line(vector.x,vector.y,vector.tx , vector.ty)
            love.graphics.print(vector.name.." = length:"..vector.length..", angle:"..math.floor(vector.angle[1]).."°,"..vector.direction[1].."; "..math.floor(vector.angle[2]).."°,"..vector.direction[2], ww - 300,wh - 120)
            
        end
    end
end

