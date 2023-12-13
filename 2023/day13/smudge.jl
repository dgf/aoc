charToBool(c) = c == "#" ? Bool(1) : Bool(0)
parsePattern(p) = map.(charToBool, split.(split(p), ""))
splitPatterns(input) = split(rstrip(read(input, String)), "\n\n")
parsePatterns(input) = map(parsePattern, splitPatterns(input))

function findMirror(slices)
  for s in 2:length(slices)
    left = reverse(slices[1:s-1])
    right = slices[s:length(slices)]
    shortest = min(length(left), length(right))
    l = reduce(hcat, left[1:shortest])
    r = reduce(hcat, right[1:shortest])
    if count(isone, xor.(l, r)) == 1
      return s - 1
    end
  end
  return 0
end

function solve(pattern)
  rows = findMirror(eachrow(pattern))
  if rows > 0
    return rows * 100
  end
  return findMirror(eachcol(pattern))
end

patterns = permutedims.(stack.(parsePatterns(stdin)))
println("sum: ", sum(solve.(patterns)))

