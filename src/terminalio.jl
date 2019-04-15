using Match
using REPLGamesBase

function term_play(board)
    rawmode() do
        while board ≠ nothing
            clear_screen()
            displaygrid(board)

            k = readKey()

            @match k begin
                "Ctrl-C" || "q" => (board = nothing)
                direction       => (board = merge(direction, board))
            end
        end
    end
end

displaygrid(board) =
    [println(join([join(x == 0 ? "." : x, " ") for x in ys], "    ")) for ys in board]
