# group and organize data
mutable struct Core
    title::String
    windows::Dict{Int,Window}

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Core() = new("Ilia.jl", Dict{Int,Window}(1 => Window()))
    # constructor with keyword arguments
    Core(; title="Ilia.jl", windows=Dict{Int,Window}(1 => Window())) = new(title, windows)
end

# methods with multiple dispatch
function run(c::Core)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(c)
    _loop(c)
    _post(c)
end

function _pre(c::Core)
    # set error callback and load glfw
    GLFW.__init__()

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    c.windows[1].openGLpointer = GLFW.CreateWindow(c.windows[1].width, c.windows[1].heigth, c.windows[1].title)
    if c.windows[1].openGLpointer == undef
        throw(ErrorException("Failed to create GLFW Window."))
    end

    # set callbacks
    setCallbacks(c.windows[1].openGLpointer)

    # make OpenGL context current
    GLFW.MakeContextCurrent(c.windows[1].openGLpointer)

    # enable v-sync, lock fps to native monitor
    GLFW.SwapInterval(1)

    # make Window visible (after setup is complete)
    GLFW.ShowWindow(c.windows[1].openGLpointer)
end

function _loop(c::Core)
    while !GLFW.WindowShouldClose(c.windows[1].openGLpointer)
        GLFW.PollEvents()

        GLFW.SwapBuffers(c.windows[1].openGLpointer)
    end
end

function _post(c::Core)
    # terminate() already called because of __init__
    GLFW.DestroyWindow(c.windows[1].openGLpointer)
    GLFW.SetErrorCallback(nothing)

    # force garbage collection
    GC.gc()
    println("GLFW says: Goodbye!")
end

function changeScene(c::Core, index::Int)
    pass
end