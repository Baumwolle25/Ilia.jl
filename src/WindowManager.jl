module WindowManager

using GLFW

include("Node.jl")

# multiple dispatch
mutable struct window
    width
    heigth
    title
    openGLpointer
    currentScene

    # openGLpointer & currentScene get initialized as ::Undef
    window() = new(1280, 720, "Ilia.jl")
end

function get()::window
    return w = window()
end

# methods with multiple dispatch
function run(w::window)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _init(w)
    _loop(w)
end

function _init(w::window)
    # where errors get printet to, propably done in GLFW already
    GLFW.SetErrorCallback(throw)

    # initialize GLFW
    if (!GLFW.Init())
        throw(ErrorException("Unable to initialize GLFW."))
    end

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

function changeScene(w::window, index::Int)
    pass
end

end