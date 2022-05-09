module Ilia

# includes all relevant files
include("Node.jl")

# application start
function julia_main()::Cint

    win = WindowManager.get()
    win = WindowManager.run(win)

    print("Exited with Error Code: ")
    return 0
end

end # module
