using Match
using REPLGamesBase

gridtoascii(board, ys) =
    join([join(x == 0 ? "." : x, " ") for x in ys], "    ")

displaygrid(board) =
    isnothing(board) ? println() :
        [println(gridtoascii(board, ys)) for ys in board]

function term_play(board)
    rawmode() do
        clear_screen()
        displaygrid(board)
        while board ≠ nothing
            k = readKey()
            @match k begin
                "Ctrl-C" || "q" => (board = nothing)
                direction       => (board = merge(direction, board))
            end
            clear_screen()
            displaygrid(board)
            board = isplayable(board) ? board : nothing
        end
    end
end
