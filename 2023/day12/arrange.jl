lines = split.(stdin |> readlines, " ")
inputRecords = [(split(l[1], ""), parse.(Int, split(l[2], ","))) for l in lines]

function solve(records)
  arrangements = 0

  for (_, record) in enumerate(records)
    springs = record[1]
    groups = record[2]
    patterns = Array{Array{Int8}}(undef, 0)
    emtyed = map(x -> x == "." ? Int8(1) : Int8(0), springs)
    fixed = map(x -> x == "#" ? Int8(1) : Int8(0), springs)
    push!(patterns, [])

    for (g, group) in enumerate(groups)
      newPatterns = Array{Array{Int8}}(undef, 0)

      for p in patterns
        maxStart = length(springs) - length(p) - (length(groups) - g - 1) - sum(Iterators.drop(groups, g)) - group

        for x in 1:maxStart
          nextPattern = copy(p)
          push!(nextPattern, zeros(Int8, x - 1)..., ones(Int8, group)...)
          if g < length(groups)
            push!(nextPattern, 0)
          end

          nextFixed = fixed[1:length(nextPattern)]
          if iszero(emtyed[1:length(nextPattern)] .& nextPattern) && sum(nextFixed) == sum(nextFixed .& nextPattern)
            push!(newPatterns, nextPattern)
          end
        end
      end
      patterns = newPatterns
    end

    patterns = map(p -> [p..., zeros(Int8, length(springs) - length(p))...], patterns)
    filter!(p -> sum(fixed) == sum(fixed .& p), patterns)

    arrangements += length(patterns)
  end

  println("arrangements: ", arrangements)
end

solve(inputRecords)

