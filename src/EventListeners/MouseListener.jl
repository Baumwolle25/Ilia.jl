mutable struct Mouse
    scrollX::Number
    scrollY::Number
    xPos::Number
    yPos::Number
    lastX::Number
    lastY::Number
    isDraging::Bool
    mouseButtonPressed::Dict{GLFW.MouseButton,Bool}

    Mouse() = new(0, 0, 0, 0, 0, 0, false, Dict{GLFW.Key,Bool}())
    Mouse(; scrollX=0, scrollY=0, xPos=0, yPos=0, lastX=0, lastY=0, isDraging=false, mouseButtonPressed=Dict{GLFW.Key,Bool}()) = new(scrollX, scrollY, xPos, yPos, lastX, lastY, isDraging, mouseButtonPressed)
end

function mousePosCallback(m::Mouse, window, xpos, ypos)
    m.lastX = m.xPos
    m.lastY = m.yPos
    m.xPos = xpos
    m.yPos = ypos
    # draging = moving with a pressed button
    m.isDraging = true in values(m.mouseButtonPressed)
end

function mouseButtonCallback(m::Mouse, window, button, action, mods)
    if action == GLFW.PRESS
        m.mouseButtonPressed[button] = true
    elseif action == GLFW.RELEASE
        m.mouseButtonPressed[button] = false
        m.isDraging = false
    end
end

function mouseScrollCallback(m::Mouse, window, xOffset, yOffset)
    m.scrollX = xOffset
    m.scrollY = yOffset
end

function endFrame(m::Mouse)
    m.scrollX = 0
    m.scrollY = 0
    m.lastX = m.xPos
    m.lastY = m.yPos
end

function deltaX(m::Mouse)
    return m.lastX - m.xPos
end

function deltaY(m::Mouse)
    return m.lastY - m.yPos
end

function isButtonPressed(m::Mouse, button)
    return m.mouseButtonPressed[button]
end