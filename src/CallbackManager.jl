
function setCallbacks(w::Window)
    #=
    `_` is used when you syntactically need a variable, but never use it.
    This is because there are lots of times where you want a loop,
    which syntactically would need a variable to be defined.
    The reason for this convention is that knowing that a variable won’t be used
    makes code easier to read often.
    =#
    GLFW.SetWindowMaximizeCallback(w.openGLpointer, (_, maximized) -> windowMaximized(w, w.openGLpointer, maximized))
    GLFW.SetWindowFocusCallback(w.openGLpointer, (_, focused) -> windowFocused(w, focused))
    GLFW.SetWindowSizeCallback(w.openGLpointer, (_, width, heigth) -> windowSize(w, width, heigth))
    GLFW.SetWindowPosCallback(w.openGLpointer, (_, x, y) -> windowPosition(w, x, y))
    GLFW.SetWindowCloseCallback(w.openGLpointer, (_) -> windowClosing(w))

    w.mouse = Mouse()
    GLFW.SetCursorPosCallback(w.openGLpointer, (_, x, y) -> mousePosCallback(w.mouse, x, y))
    GLFW.SetMouseButtonCallback(w.openGLpointer, (_, button, action, mods) -> mouseButtonCallback(w.mouse, button, action, mods))
    GLFW.SetScrollCallback(w.openGLpointer, (_, xoff, yoff) -> mouseScrollCallback(w.mouse, xoff, yoff))

    w.keyboard = Keyboard()
    GLFW.SetKeyCallback(w.openGLpointer, (_, key, scancode, action, mods) -> keyCallback(w.keyboard, key, scancode, action, mods))

    # still left to do
    GLFW.SetDropCallback(w.openGLpointer, (_, paths) -> println(paths))
    GLFW.SetCharModsCallback(w.openGLpointer, (_, c, mods) -> println("char: $c, mods: $mods"))
    GLFW.SetWindowIconifyCallback(w.openGLpointer, (_, iconified) -> println("window iconify: $iconified"))
    GLFW.SetMonitorCallback((monitor, event) -> println("$monitor $event"))
    GLFW.SetJoystickCallback((joystick, event) -> println("$joystick $event"))
end