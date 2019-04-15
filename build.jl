using Pkg

Pkg.add("JSON2")
Pkg.add("Blink")
Pkg.add("Match")
Pkg.clone("https://github.com/JuliaData/SplitApplyCombine.jl")
Pkg.clone("https://github.com/ChristianKurz/REPLGamesBase.jl")

using Blink
Blink.AtomShell.install()
