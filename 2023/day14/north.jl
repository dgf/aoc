readPlatform(input) = input |> readlines |> stack |> permutedims

function tiltNorth!(platform)
  for (c, col) in enumerate(eachcol(platform))
    frees = Int8[]
    newCol = fill('.', length(col))
    for (r, row) in enumerate(col)
      if row == '.'
        push!(frees, r)
      elseif row == '#'
        frees = Int8[]
        newCol[r] = '#'
      elseif row == 'O'
        if isempty(frees)
          newCol[r] = 'O'
        else
          newCol[popfirst!(frees)] = 'O'
          push!(frees, r)
        end
      end
    end
    platform[:, c] = newCol
  end
end

platform = readPlatform(stdin)
tiltNorth!(platform)

indizes = findall(isequal('O'), reverse(platform; dims=1))
counts = map(i -> i[1], indizes)
total = sum(counts)
println("total: $total")

