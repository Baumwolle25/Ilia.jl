module Ilia

# all imports
using GLFW, ModernGL
using Base.Threads

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# organize modules
include("EventListeners/MouseListener.jl")
include("EventListeners/KeyListener.jl")
include("EventListeners/WindowListener.jl")
include("Scene/Scene.jl")
include("Utilities/Time.jl")
include("CallbackManager.jl")
include("Core.jl")
include("WindowManager.jl")

# application start
function julia_main()::Cint

    global c = Core()
    run(c)

    return 0
end

end # module
