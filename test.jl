using Pkg

Pkg.activate(".")
Pkg.instantiate()

push!(LOAD_PATH, "test/")

Pkg.test(coverage=true)
