using Base.Threads
using Pkg

# look for env and load
if isfile("Project.toml") && isfile("Manifest.toml")
    Pkg.activate(".")
    Pkg.instantiate()
end

# set threads to max
Threads.nthreads() = Sys.CPU_THREADS

# add folder so main.jl can find it
function set_source()
    for element in readdir()
        if element == "src"
            return true
        end
    end
    return false
end

if set_src()
    push!(LOAD_PATH, "src/")
end
