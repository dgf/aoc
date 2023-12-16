@enum Direction up down right left
readLayout(input) = input |> readlines |> stack |> permutedims
getBeamVector(l, b) = b[1] in [right, left] ? (b[2][2], l[b[2][1], :]) : (b[2][1], l[:, b[2][2]])

function solve(layout, startBeam)
  beams = [startBeam]
  seen = Set{Tuple{Direction,CartesianIndex}}()
  energized = Set{CartesianIndex}()

  while !isempty(beams)
    beam = popfirst!(beams)
    if beam in seen
      continue
    end
    push!(seen, beam)
    direction = beam[1]
    index, vector = getBeamVector(layout, beam)
    directionRange = (direction in [right, down]) ? (index+1:length(vector)) : (index-1:-1:1)
    for i in directionRange
      n = vector[i]
      ci = direction in [right, left] ? CartesianIndex(beam[2][1], i) : CartesianIndex(i, beam[2][2])
      push!(energized, ci)
      if n == '|' && direction in [right, left]
        push!(beams, (up, ci))
        push!(beams, (down, ci))
        break
      end
      if n == '-' && direction in [up, down]
        push!(beams, (left, ci))
        push!(beams, (right, ci))
        break
      end
      if n == '\\'
        if direction == right
          push!(beams, (down, ci))
        elseif direction == left
          push!(beams, (up, ci))
        elseif direction == up
          push!(beams, (left, ci))
        elseif direction == down
          push!(beams, (right, ci))
        end
        break
      end
      if n == '/'
        if direction == right
          push!(beams, (up, ci))
        elseif direction == left
          push!(beams, (down, ci))
        elseif direction == up
          push!(beams, (right, ci))
        elseif direction == down
          push!(beams, (left, ci))
        end
        break
      end
    end
  end

  return length(energized)
end

function getMaxVariant(layout)
  maxEnergized = 0
  for r in 1:size(layout, 1)
    re = solve(layout, (right, CartesianIndex(r, 0)))
    le = solve(layout, (left, CartesianIndex(r, size(layout, 2))))
    if re > maxEnergized
      maxEnergized = re
    elseif le > maxEnergized
      maxEnergized = le
    end
  end
  for c in 1:size(layout, 2)
    de = solve(layout, (down, CartesianIndex(0, c)))
    ue = solve(layout, (up, CartesianIndex(size(layout, 1), c)))
    if de > maxEnergized
      maxEnergized = de
    elseif ue > maxEnergized
      maxEnergized = ue
    end
  end
  return maxEnergized
end

layout = readLayout(stdin)
maxEnergized = getMaxVariant(layout)
println("energized: $maxEnergized")

