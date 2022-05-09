module MouseListener

mutable struct mouse
    scrollX::Float64
    scrollY::Float64
    xPos::Float64
    yPos::Float64
    lastX::Float64
    lastY::Float64
    isDraging::Bool
    mouseButtonPressed::Vector{Bool}

    mouse() = new(0, 0, 0, 0, 0, 0, false)
end

_m = mouse()

function get()::mouse
    global _m
    return _m
end

end