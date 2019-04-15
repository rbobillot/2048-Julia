using Pkg

Pkg.add("JSON2")
Pkg.add("Blink")
Pkg.add("Match")
Pkg.clone("https://github.com/JuliaData/SplitApplyCombine.jl")

using Blink
Blink.AtomShell.install()
