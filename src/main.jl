
include("terminalio.jl")
include("gamelogic.jl")

using Match
using SplitApplyCombine

function main(args)

    xs = [
    [0,0,0,0],
    [0,2,2,0],
    [0,0,0,0],
    [0,0,0,0]]

    mainboard = splitdims(zeros(Int, 4,4), 1)

    term_play(xs)

end

main(ARGS)
