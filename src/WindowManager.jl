module WindowManager

using GLFW

export get

# group and organize data
mutable struct window
    width
    heigth
    title
    openGLpointer
    currentScene

    # openGLpointer & currentScene get initialized as ::Undef
    window() = new(1280, 720, "Ilia.jl")
end

# Singelton
_w = window()

function get()::window
    global _w
    return _w
end

# methods with multiple dispatch
function run(w::window)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(w)
    _loop(w)
    _post(w)
end

function _pre(w::window)
    # set error callback and load glfw
    GLFW.__init__()

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    w.openGLpointer = GLFW.CreateWindow(w.width, w.heigth, w.title)
    if w == 0
        throw(ErrorException("Failed to create GLFW Window."))
    end

    # make OpenGL context current
    GLFW.MakeContextCurrent(w.openGLpointer)

    # enable v-sync, lock fps to native monitor
    GLFW.SwapInterval(1)

    # make Window visible (after setup is complete)
    GLFW.ShowWindow(w.openGLpointer)
end

function _loop(w::window)
    while !GLFW.WindowShouldClose(w.openGLpointer)
        GLFW.PollEvents()

        GLFW.SwapBuffers(w.openGLpointer)
    end
end

function _post(w::window)
    # terminate already called because of __init__
    GLFW.DestroyWindow(w.openGLpointer)
    GLFW.SetErrorCallback(nothing)

    # force garbage collection
    GC.gc()
    println("GLFW says: Goodbye!")
end

function changeScene(w::window, index::Int)
    pass
end

end