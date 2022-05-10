
function setCallbacks(w::GLFW.Window)
    #=
    `_` is used when you syntactically need a variable, but never use it.
    This is because there are lots of times where you want a loop,
    which syntactically would need a variable to be defined.
    The reason for this convention is that knowing that a variable won’t be used
    makes code easier to read often.
    =#
    global m = Mouse()
    GLFW.SetCursorPosCallback(w, (_, x, y) -> mousePosCallback(m, w, x, y))
    GLFW.SetMouseButtonCallback(w, (_, button, action, mods) -> mouseButtonCallback(m, w, button, action, mods))
    GLFW.SetScrollCallback(w, (_, xoff, yoff) -> mouseScrollCallback(m, w, xoff, yoff))

    global k = Keyboard()
    GLFW.SetKeyCallback(w, (_, key, scancode, action, mods) -> keyCallback(k, w, key, scancode, action, mods))
end