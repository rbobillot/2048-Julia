dropzeros(row::Array{Int})::Array{Int} =
    filter(!iszero, row)

lpadrow(row::Array{Int})::Array{Int} =
    append!(zeros(Int, 4 - length(row)), row)

evalfunctioncall(call::String) =
    call |> Meta.parse |> eval
