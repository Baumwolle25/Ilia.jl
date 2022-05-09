using Pkg

cd("..")
Pkg.activate(".")
Pkg.instatiate()

Pkg.add("PackageCompiler")
using PackageCompiler

create_app("Ilia", "Ilia")