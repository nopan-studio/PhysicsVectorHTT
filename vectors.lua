 -- vectors

    --[[
        to add vectors
        {
            name = "name of vector",
            length = length of the vector,
            angle = angle in degrees
            direction = check table below for directions,
        }
    ]]

    --[[
        DIRECTIONS
        "N" = north
        "S" = south
        "W" = west
        "E" = east

        for combined direction just follow this example.. 
        also this is case sensitive so ya,know follow the method strictly.

        "NoW" = North of West
        "WoN" = West of North
        "SoW" ..
        "WoS" ..
    ]]

    return {

        {
            name = "d1",
            length = 6, 
            angle = 0, 
            direction = "E"
        },
            
        {
            name = "d2",
            length = 7, 
            angle = 40, 
            direction = "SoE"
        },
    
        {
            name = "d3",
            length = 9, 
            angle = 90,
            direction = "S"
        },
    
        {
            name = "d4",
            length = 4, 
            angle = 30, 
            direction = "NoW"
        },
        
        {
            name = "d5",
            length = 8, 
            angle = 70,
            direction = "SoW"
        },

        -- dont remove. this is your resultant vector.
        {
            name = "R",
        }
    }