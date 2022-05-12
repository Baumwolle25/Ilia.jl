using Pkg

Pkg.activate(".")
Pkg.instantiate()

push!(LOAD_PATH, "src/")

using Ilia

Ilia.julia_main()