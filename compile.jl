using Pkg

cd("..")
Pkg.activate(".")
Pkg.instantiate()

Pkg.add("PackageCompiler")
using PackageCompiler

create_app("Ilia", "Ilia_Compiled")
