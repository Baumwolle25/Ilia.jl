# group and organize data
mutable struct Window
    width::Number
    heigth::Number
    title::String
    openGLpointer::GLFW.Window
    currentScene::Number

    # openGLpointer & currentScene get initialized as ::Undef
    Window() = new(1280, 720, "Ilia.jl")
end

# methods with multiple dispatch
function run(w::Window)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(w)
    _loop(w)
    _post(w)
end

function _pre(w::Window)
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

function _loop(w::Window)
    while !GLFW.WindowShouldClose(w.openGLpointer)
        GLFW.PollEvents()

        GLFW.SwapBuffers(w.openGLpointer)
    end
end

function _post(w::Window)
    # terminate() already called because of __init__
    GLFW.DestroyWindow(w.openGLpointer)
    GLFW.SetErrorCallback(nothing)

    # force garbage collection
    GC.gc()
    println("GLFW says: Goodbye!")
end

function changeScene(w::Window, index::Int)
    pass
end