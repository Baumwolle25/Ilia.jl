# group and organize data
mutable struct Core
    title::String
    windows::Array{Window,1}
    currentScene::Scene

    # openGLpointer & currentScene get initialized as ::Undef
    # standart empty consructor
    Core() = new("Ilia.jl", Array{Window,1}())
    # constructor with keyword arguments
    Core(; title="Ilia.jl", windows=Array{Window,1}(), currentScene=Scene()) = new(title, windows, currentScene)
end

# methods with multiple dispatch
function run(c::Core)
    println("GLFW making the world turn with v", GLFW.GetVersion())

    _pre(c)
    _loop(c)
    _post(c)
end

# what does that do? undocumented but in examples
glClear() = ccall(@eval(GLFW.GetProcAddress("glClear")), Cvoid, (Cuint,), 0x00004000)

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
end

function _loop(c::Core)
    global t = Time()
    while true
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
            glClear()

            # testing for multiple windows
            if isKeyPressed(window.keyboard, GLFW.KEY_SPACE)
                addWindow(c)
            end

            global c
            if isKeyPressed(window.keyboard, GLFW.KEY_1)
                changeScene(c,1)
            elseif isKeyPressed(window.keyboard, GLFW.KEY_2)
                changeScene(c,2)
            end
            # clear window
            GLFW.SwapBuffers(window.openGLpointer)
        end
        global t
        time(t)
    end
end

function _post(c::Core)
    GLFW.SetErrorCallback(nothing)

    # force garbage collection
    GC.gc()
    println("GLFW says: Goodbye!")
end

