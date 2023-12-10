@enum Direction begin
  up = 1
  down = 2
  right = 3
  left = 4
end

transitions = Dict([
  (up, Set("|F7")),
  (down, Set("|JL")),
  (right, Set("-J7")),
  (left, Set("-FL")),
])

movements = Dict([
  ('|', Set([up, down])),
  ('-', Set([left, right])),
  ('L', Set([up, right])),
  ('J', Set([up, left])),
  ('7', Set([down, left])),
  ('F', Set([down, right])),
  ('S', Set([up, down, right, left])),
])

neighbours = Dict([
  (up, CartesianIndex(-1, 0)),
  (down, CartesianIndex(1, 0)),
  (left, CartesianIndex(0, -1)),
  (right, CartesianIndex(0, 1)),
])

lines = stdin |> readlines
grid = map(first, split.(lines, "") |> stack |> permutedims)

gridAxes = axes(grid)
gridLines = gridAxes[begin].stop
gridRows = gridAxes[end].stop

startPosition = findfirst(x -> x == 'S', grid)

function nexts(i::CartesianIndex)
  c = grid[i]

  nextPositions = CartesianIndex{2}[]
  for d in movements[c]
    n = neighbours[d]

    neighbourPosition = n + i

    neighbourLine = neighbourPosition.I[begin]
    neighbourRow = neighbourPosition.I[end]
    if 0 < neighbourLine <= gridLines && 0 < neighbourRow <= gridRows
      nv = grid[neighbourPosition]
      t = transitions[d]
      if in(nv, t)
        push!(nextPositions, neighbourPosition)
      end
    end
  end

  return nextPositions
end

visited = Array{CartesianIndex{2}}(undef, 1)
push!(visited, startPosition)
queue = nexts(startPosition)
steps = 0

while !isempty(queue)
  newQueue = CartesianIndex{2}[]
  for toCheck in queue
    for n in nexts(toCheck)
      if !in(n, visited)
        push!(newQueue, n)
        push!(visited, n)
      end
    end
  end
  global queue = newQueue
  global steps += 1
end

println("steps: ", steps)

