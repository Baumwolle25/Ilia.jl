# all imports
using GLFW
using Base.Threads

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# organize modules
include("EventListeners/MouseListener.jl")
include("CallbackManager.jl")
include("WindowManager.jl")