readDigPlan1(lines) = map(s -> (Char(s[1][1]), parse(Int, s[2])), lines)

directionChars = ['R', 'D', 'L', 'U']
hexDirection(s) = (directionChars[parse(Int8, s[3][end-1])+1], parse(Int64, s[3][3:end-2]; base=16))
readDigPlan2(lines) = map(hexDirection, lines)

function iterTrench(direction, meters)
  if direction == 'R'
    return (0, meters)
  elseif direction == 'D'
    return (meters, 0)
  elseif direction == 'L'
    return (0, -meters)
  elseif direction == 'U'
    return (-meters, 0)
  end
end

function paintDigPlan(plan)
  index = (1, 1)
  indizes = Tuple{Int64,Int64}[]
  boundaries = 0
  for trench in plan
    row, col = iterTrench(trench[1], trench[2])
    boundaries += trench[2]
    index = (index[1] + row, index[2] + col)
    push!(indizes, index)
  end

  minIndex = minimum(indizes)
  m = map(i -> (i[1] - minIndex[1] + 1, i[2] - minIndex[2] - 1), indizes)

  # Trapezoid formula
  innerArea = sum(i -> (m[i][1] + m[i+1][1]) * (m[i][2] - m[i+1][2]), eachindex(m[1:end-1]))
  innerArea = (innerArea + (m[end][1] + m[1][1]) * (m[end][2] - m[1][2])) / 2
  println("inner area = $innerArea")

  # Pick's theorem
  innerPoints = innerArea - (boundaries / 2) + 1
  println("inner points = $innerArea - ($boundaries / 2) + 1 = $innerPoints")
  completeArea = innerPoints + boundaries
  println("complete area = $innerPoints + $boundaries = $(trunc(Int64, completeArea))")
end

lines = map(split, stdin |> readlines)

println(repeat("-", 73))
println("part 1")
paintDigPlan(readDigPlan1(lines))

println(repeat("-", 73))
println("part 2")
paintDigPlan(readDigPlan2(lines))

println(repeat("-", 73))

