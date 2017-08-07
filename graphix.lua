--[[
    rdh - graphix.lua  20160131
    version - 1.0
]]

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-- center of screen is 640, 360
function draw_stuff(cr)

    local light_blue = 0xa5f3f8
    local dark_blue = 0x2b91c6
    local red = 0xff0000
    local yellow = 0xffff00
    local orange = 0xff8800
    local light_green = 0x88ff00


    cairo_set_line_width(cr, 3.0)

    cairo_set_source_rgba(cr,rgb_to_r_g_b(light_blue, 1.0))

    -- Top left lines
    cairo_move_to(cr, 580.0, 260.0)
    cairo_line_to(cr, 515.0, 220.0)

    cairo_move_to(cr, 515.0, 220.0)
    cairo_line_to(cr, 200.0, 220.0)

    -- Top right lines
    cairo_move_to(cr, 700.0, 260.0)
    cairo_line_to(cr, 765.0, 220.0)

    cairo_move_to(cr, 765.0, 220.0)
    cairo_line_to(cr, 1080.0, 220.0)

    -- Bottom left lines
    cairo_move_to(cr, 585.0, 460.0)
    cairo_line_to(cr, 520.0, 500.0)

    cairo_move_to(cr, 520.0, 500.0)
    cairo_line_to(cr, 200.0, 500.0)

    -- Bottom right lines
    cairo_move_to(cr, 695.0, 460.0)
    cairo_line_to(cr, 760.0, 500.0)

    cairo_move_to(cr, 760.0, 500.0)
    cairo_line_to(cr, 1080.0, 500.0)

    cairo_stroke(cr) -- draw the lines

    -- Rectangles
    cairo_set_line_width(cr, 1.0)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(light_blue, 0.2))

    --Top left rectangle
    cairo_rectangle(cr, 200.0, 220.0, 315.0, 40.0)

    --Top right rectangle
    cairo_rectangle(cr, 765.0, 220.0, 315.0, 40.0)

    --Bottom left rectangle
    cairo_rectangle(cr, 200.0, 500.0, 320.0, 40.0)

    --Bottom right rectangle
    cairo_rectangle(cr, 760.0, 500.0, 320.0, 40.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Cpu bars ; grows right to left
    local str=''
    local pct = 0
    local value = 0
    
    --Cpu 1
    cairo_set_source_rgba(cr,rgb_to_r_g_b(red, .2))
    str = string.format('${%s %s}', 'cpu', 'cpu1')
    str = conky_parse(str)
        
    value = tonumber(str)
    pct = (value / 100) * 315.0

    cairo_rectangle(cr, (515.0 - pct), 220.0, pct, 10.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Cpu 2
    cairo_set_source_rgba(cr,rgb_to_r_g_b(orange, .2))
    str = string.format('${%s %s}', 'cpu', 'cpu2')
    str = conky_parse(str)
        
    value = tonumber(str)
    pct = (value / 100) * 315.0

    cairo_rectangle(cr, (515.0 - pct), 230.0, pct, 10.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Cpu 3
    cairo_set_source_rgba(cr,rgb_to_r_g_b(yellow, .2))
    str = string.format('${%s %s}', 'cpu', 'cpu3')
    str = conky_parse(str)
        
    value = tonumber(str)
    pct = (value / 100) * 315.0

    cairo_rectangle(cr, (515.0 - pct), 240.0, pct, 10.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Cpu 4
    cairo_set_source_rgba(cr,rgb_to_r_g_b(light_green, .2))
    str = string.format('${%s %s}', 'cpu', 'cpu4')
    str = conky_parse(str)
        
    value = tonumber(str)
    pct = (value / 100) * 315.0

    cairo_rectangle(cr, (515.0 - pct), 250.0, pct, 10.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Memory bar ; grows left to right
    cairo_set_source_rgba(cr,rgb_to_r_g_b(light_blue, 0.25))
    str = string.format('${%s}', 'memperc')
    str = conky_parse(str)

    value = tonumber(str)
    pct = (value / 100) * 315.0

    cairo_rectangle(cr, 765.0, 220.0, pct, 40.0)

    --Disk bar ; grows right to left
    str = string.format('${%s %s}', 'fs_used_perc', '/')
    str = conky_parse(str)

    value = tonumber(str)
    pct = (value / 100) * 320.0

    cairo_rectangle(cr, (520.0 - pct), 500.0, pct, 40.0)
    
    cairo_fill(cr)
    cairo_stroke(cr)

    --Download bar ; grows left to right
    cairo_set_source_rgba(cr,rgb_to_r_g_b(light_green, .2))
    str = string.format('${%s %s}', 'downspeedf', 'wlp1s0')
    str = conky_parse(str)

    value = tonumber(str)
    pct = (value / 2774.0) * 320.0 --2774.0 Kib is max download speed

    cairo_rectangle(cr, 760.0, 500.0, pct, 20.0)

    cairo_fill(cr)
    cairo_stroke(cr)

    --Upload bar ; grows left to right
    cairo_set_source_rgba(cr,rgb_to_r_g_b(yellow, .2))
    str = string.format('${%s %s}', 'upspeedf', 'wlp1s0')
    str = conky_parse(str)

    value = tonumber(str)
    pct = (value / 400.0) * 320.0 --400.0 Kib is max upload speed

    cairo_rectangle(cr, 760.0, 520.0, pct, 20.0) --below Download bar

    cairo_fill(cr)
    cairo_stroke(cr)

    -- Larger Rectangles
    cairo_set_line_width(cr, 1.0)
    cairo_set_source_rgba(cr,rgb_to_r_g_b(dark_blue, 0.2))

    --Middle left rectangle
    cairo_rectangle(cr, 200.0, 270.0, 250.0, 100.0)

    --Middle right rectangle
    cairo_rectangle(cr, 830.0, 270.0, 250.0, 100.0)

    cairo_fill(cr)
    cairo_stroke(cr)

end

function conky_graphix()

    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)

    if conky_window == nil then return end

    if update_num > 5 then
        -- do stuff in here
        local cs = cairo_xlib_surface_create(conky_window.display,
                                           conky_window.drawable,
                                           conky_window.visual, 
                                           conky_window.width,
                                           conky_window.height)

        local cr = cairo_create(cs)

        draw_stuff(cr)

        cairo_destroy(cr) -- need to make sure this happens
    end
end
