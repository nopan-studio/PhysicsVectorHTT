simp = require "libs.Simply"
--
require "htt"
require "cm"
hey = require "vectors"

local mode = "CM"

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function love.load()
    vectors = deepcopy(hey)

    love.window.setMode( 800, 600, {minwidth=800,minheight=600})

    font = love.graphics.newFont("Asana-Math.otf",15)
    love.graphics.setFont(font)

    simp.load()

    button1 = simp.new_button({
        name = "CM",
        isVisible = true,
        x = 10,
        y = 50,
        w = 35,
        h = 35,
        style = "line",
        pressed = function()
            mode = "CM"    
            love.load()
        end,
    })

    button2 = simp.new_button({
        name = "GM",
        isVisible = true,
        x = 10,
        y = 50+35+10,
        w = 35,
        h = 35,
        style = "line",
        pressed = function()
            mode = "HTT"
            love.load()

        end,
    })
    
    if mode == "CM" then
        cm:load()
    elseif mode == "HTT" then
        htt:load()
    end

end

function love.mousepressed(x,y,button)
    simp.mousepressed(x,y,button)
end

function love.update(dt)
    htt:update(dt)
    simp.update()
end

function love.draw()
    

    love.graphics.setColor(1,1,1)
    if mode == "menu" then

    elseif mode == "CM" then
        cm:draw()
    elseif mode == "HTT" then
        htt:draw()
    end
    simp.draw()

end

