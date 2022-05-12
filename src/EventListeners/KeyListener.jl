mutable struct Keyboard
    keyPressed::Dict{GLFW.Key,Bool}

    Keyboard() = new(Dict{GLFW.Key,Bool}())
    Keyboard(; keyPressed=Dict{GLFW.Key,Bool}()) = new(keyPressed)
end

function keyCallback(k::Keyboard, window, key, scancode, action, mods)
    if action == GLFW.PRESS
        k.keyPressed[key] = true
    elseif action == GLFW.RELEASE
        k.keyPressed[key] = false
    end
end

function isKeyPressed(k::Keyboard, key)
    if !(key in keys(k.keyPressed))
        k.keyPressed[key] = false
    end
    return k.keyPressed[key]
end