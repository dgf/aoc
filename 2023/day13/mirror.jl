charToBool(c) = c == "#" ? Bool(1) : Bool(0)
parsePattern(p) = map.(charToBool, split.(split(p), ""))
splitPatterns(input) = split(rstrip(read(input, String)), "\n\n")
parsePatterns(input) = map(parsePattern, splitPatterns(input))

function findMirror(slices)
  for s in 2:length(slices)
    left = reverse(slices[1:s-1])
    right = slices[s:length(slices)]
    shortest = min(length(left), length(right))
    if left[1:shortest] == right[1:shortest]
      return s - 1
    end
  end
  return 0
end

function solve(pattern)
  rowMatch = findMirror(eachrow(pattern))
  colMatch = findMirror(eachcol(pattern))
  return 100 * rowMatch + 1 * colMatch
end

patterns = permutedims.(stack.(parsePatterns(stdin)))
println("sum: ", sum(solve.(patterns)))

