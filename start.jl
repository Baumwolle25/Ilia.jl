using Pkg

push!(LOAD_PATH, "src/")

Pkg.activate(".")
Pkg.instantiate()

using Ilia

Ilia.julia_main()