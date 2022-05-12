# group and organize data
mutable struct Core
    title::String
    windows::Array{Window,1}

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Core() = new("Ilia.jl", Array{Window,1}())
    # constructor with keyword arguments
    Core(; title="Ilia.jl", windows=Array{Window,1}()) = new(title, windows)
end

# methods with multiple dispatch
function run(c::Core)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(c)
    _loop(c)
    _post(c)
end


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
    setCallbacks(last(c.windows).openGLpointer)

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

function _pre(c::Core)
    # set error callback and load glfw
    GLFW.__init__()

    # configure GLFW
    GLFW.DefaultWindowHints()
    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.RESIZABLE, true)
    GLFW.WindowHint(GLFW.MAXIMIZED, true)

    # start first window
    addWindow(c)

    # enable v-sync, lock fps to native monitor
    GLFW.SwapInterval(1)

    # make Window visible (after setup is complete)
    for window in c.windows
        GLFW.ShowWindow(window.openGLpointer)
    end
end

function _loop(c::Core)
    while true
        println(c.windows)
        # should any window close?
        for window in c.windows
            if GLFW.WindowShouldClose(window.openGLpointer)
                removeWindow(c, findfirst(x -> x == window, c.windows))
            end
        end
        # there are no windows anymore
        if isempty(c.windows)
            break
        end
        # update all windows that are left
        for window in c.windows
            # for every window sepperatly
            GLFW.MakeContextCurrent(window.openGLpointer)
            GLFW.PollEvents()

            # testing for multiple windows
            global k
            if isKeyPressed(k, GLFW.KEY_SPACE)
                addWindow(c)
            end

            # clear window
            GLFW.SwapBuffers(window.openGLpointer)
        end
    end
end

function _post(c::Core)
    GLFW.SetErrorCallback(nothing)

    # force garbage collection
    GC.gc()
    println("GLFW says: Goodbye!")
end

function changeScene(c::Core, index::Int)
    pass
end