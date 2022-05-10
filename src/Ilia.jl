module Ilia

# all imports
using GLFW
using Base.Threads

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# organize modules
include("EventListeners/MouseListener.jl")
include("WindowManager.jl")

# application start
function julia_main()::Cint

    window = Window()
    window = run(window)

    return 0
end

end # module
