using Base.Threads

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# organize modules
include("WindowManager.jl")
include("CallbackManager.jl")

include("EventListeners/MouseListener.jl")