module MouseListener

mutable struct mouse
    scrollX::Float64
    scrollY::Float64
    xPos::Float64
    yPos::Float64
    lastX::Float64
    lastY::Float64
    isDraging::Bool
    mouseButtonPressed::Array{Bool,1}
    # array with booleans of 1 demension filled with false and a length of 7
    mouse() = new(0, 0, 0, 0, 0, 0, false, Array{Bool,1}(undef, 7))
end

_m = mouse()

function get()::mouse
    global _m
    return _m
end

function mousePosCallback(m::mouse, window, xpos, ypos)
    m.lastX = m.xPos
    m.lastY = m.yPos
    m.xPos = xpos
    m.yPos = ypos
end

function mouseButtonCallback(m::mouse, window, button, action, mods)
    if action == GLFW.PRESS | action == GLFW.REPEAT
        m.mouseButtonPressed[button] = true
    elseif action == GLFW.RELEASE
        m.mouseButtonPressed[button] = false
        m.isDraging = false
    end
end

function mouseScrollCallback()

end

end