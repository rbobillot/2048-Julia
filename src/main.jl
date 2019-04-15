using Match
using SplitApplyCombine

dropzeros(row) = filter(!iszero, row)

lpadrow(row) = append!(zeros(Int, 4 - length(row)), row)

cleanrow(row) = row |> dropzeros |> lpadrow

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

merge_u(board) = invert(merge_r(invert(board)))

merge_d(board) = invert(merge_l(invert(board)))

function main(args)

    xs = splitdims([
    0 0 2 0;
    4 2 0 0;
    2 0 2 0;
    0 2 0 2], 1)

    println(merge_r(xs))
    println(merge_l(xs))
    println(merge_u(xs))
    println(merge_d(xs))

end

main(ARGS)
