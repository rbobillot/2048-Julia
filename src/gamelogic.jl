include("utils.jl")

using Match
using SplitApplyCombine

Board = Array{Array{Int64,1},1}

cleanrow(row) = row |> dropzeros |> lpadrow

isplayable(board) =
    isnothing(board) ? false :
        board |> merge_r |> merge_l |> merge_d |> merge_u |>
            nextboard -> all(!iszero, nextboard) ≠ board

getidentifier(str) =
    isempty(str) ? ' ' : str[1] |> lowercase

isdirection(direction) =
    direction |> getidentifier |> i -> i ∈ ['r', 'l', 'd', 'u']

merge_row(row) = cleanrow(@match cleanrow(row) begin
    [a,b,c,d], if a ≠ b ≠ c ≡ d end => [a,b,c+d] # [a,b,c,c]
    [a,b,c,d], if a ≠ b ≡ c ≡ d end => [a,b,c+d] # [a,b,b,b]
    [a,b,c,d], if a ≠ b ≡ c ≠ d end => [a,b+c,d] # [a,b,b,c]
    [a,b,c,d], if a ≡ b ≠ c ≡ d end => [a+b,c+d] # [a,a,b,b]
    [a,b,c,d], if a ≡ b ≡ c ≡ d end => [a+b,c+d] # [a,a,a,a]
    [a,b,c,d], if a ≡ b ≡ c ≠ d end => [a,b+c,d] # [a,a,a,b]
    [a,b,c,d], if a ≡ b ≠ c ≠ d end => [a+b,c,d] # [a,a,b,c]
    xs                              => xs
end)

merge_r(board) = [merge_row(row) for row in board]

merge_l(board) = [reverse(merge_row(reverse(r))) for r in board]

merge_d(board) = invert(merge_r(invert(board)))

merge_u(board) = invert(merge_l(invert(board)))

mergeboard(direction, board) =
    "merge_$(direction |> getidentifier)($board)" |> evalfunctioncall

function addtile(board)
    if all(!iszero, board)
        board
    else
        n = length(board)
        x = randint(n)
        y = randint(n)
        iszero(board[x][y]) ? board[x][y] = 2 : addtile(board)
        sleep(0.7)
        board
    end
end

function merge(direction::String, board::Board)::Board
    merged = isdirection(direction) ? mergeboard(direction, board) : board
    merged ≠ board ? addtile(merged) : board
end
