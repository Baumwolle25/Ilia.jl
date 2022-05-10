module Ilia

# all imports
using GLFW
using Base.Threads

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# organize modules
include("EventListeners/MouseListener.jl")
include("EventListeners/KeyListener.jl")
include("CallbackManager.jl")
include("WindowManager.jl")

# application start
function julia_main()::Cint

    global w = Window()
    w = run(w)

    return 0
end

end # module
