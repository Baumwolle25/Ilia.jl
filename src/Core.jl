# group and organize data
mutable struct Core
    title::String
    index::Int
    windows::Dict{Int,Window}

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Core() = new("Ilia.jl", 0, Dict{Int,Window}())
    # constructor with keyword arguments
    Core(; title="Ilia.jl", index=0, windows=Dict{Int,Window}()) = new(title, index, windows)
end

# methods with multiple dispatch
function run(c::Core)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(c)
    println(c.index)
    _loop(c)
    _post(c)
end

function addWindow(c::Core)
    c.index += 1
    c.windows[c.index] = Window()

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    c.windows[c.index].openGLpointer = GLFW.CreateWindow(c.windows[c.index].width, c.windows[c.index].heigth, c.windows[c.index].title)
    if c.windows[c.index].openGLpointer == undef
        throw(ErrorException("Failed to create GLFW Window."))
    end

    # set callbacks
    setCallbacks(c.windows[c.index].openGLpointer)

    GLFW.MakeContextCurrent(c.windows[c.index].openGLpointer)

    # make Window visible (after setup is complete)
    GLFW.ShowWindow(c.windows[c.index].openGLpointer)
    println("adding window")
end

function removeWindow(c::Core, index)
    println("removing window")
    c.index -= 1
    GLFW.DestroyWindow(c.windows[index].openGLpointer)
end

function _pre(c::Core)
    # set error callback and load glfw
    GLFW.__init__()

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    addWindow(c)
    # enable v-sync, lock fps to native monitor
    GLFW.SwapInterval(1)

    # make Window visible (after setup is complete)
    for (index, window) in c.windows
        GLFW.ShowWindow(window.openGLpointer)
    end
end

function _loop(c::Core)
    exit = false
    while !exit
        for (index, window) in c.windows
            if GLFW.WindowShouldClose(window.openGLpointer)
                removeWindow(c, index)
                println(index)
            end

            # for every window sepperatly
            GLFW.MakeContextCurrent(c.windows[c.index].openGLpointer)
            GLFW.PollEvents()

            global k
            if isKeyPressed(k, GLFW.KEY_SPACE)
                addWindow(c)
                println(index)
            end

            GLFW.SwapBuffers(window.openGLpointer)
        end
        # there are no windows anymore
        if c.index < 1
            println("set exit to true")
            exit = true
        end
    end
end

function _post(c::Core)
    println("in post")
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