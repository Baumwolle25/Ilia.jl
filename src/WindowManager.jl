function addWindow(c::Core)
    # array is ordered list so last() gives this new window
    push!(c.windows, Window(; title=c.title))

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    last(c.windows).openGLpointer = GLFW.CreateWindow(last(c.windows).width, last(c.windows).heigth, last(c.windows).title)
    if last(c.windows).openGLpointer == undef
        throw(ErrorException("Failed to create GLFW Window."))
    end

    # set callbacks
    setCallbacks(last(c.windows))

    GLFW.MakeContextCurrent(last(c.windows).openGLpointer)

    # make Window visible (after setup is complete)
    GLFW.ShowWindow(last(c.windows).openGLpointer)
end

function removeWindow(c::Core, index)
    # let glfw handle stuff
    GLFW.DestroyWindow(c.windows[index].openGLpointer)

    # clean up Core
    popat!(c.windows, index)
end