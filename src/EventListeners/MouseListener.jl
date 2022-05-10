mutable struct Mouse
    scrollX::Number
    scrollY::Number
    xPos::Number
    yPos::Number
    lastX::Number
    lastY::Number
    isDraging::Bool
    mouseButtonPressed::Array{Bool,1}
    # array with booleans of 1 demension filled with false and a length of 7
    mouse() = new(0, 0, 0, 0, 0, 0, false, Array{Bool,1}(undef, 7))
end

function mousePosCallback(m::Mouse, window, xpos, ypos)
    m.lastX = m.xPos
    m.lastY = m.yPos
    m.xPos = xpos
    m.yPos = ypos
end

function mouseButtonCallback(m::Mouse, window, button, action, mods)
    if action == GLFW.PRESS | action == GLFW.REPEAT
        m.mouseButtonPressed[button] = true
    elseif action == GLFW.RELEASE
        m.mouseButtonPressed[button] = false
        m.isDraging = false
    end
end

function mouseScrollCallback()

end