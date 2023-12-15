joinLines(input) = replace(read(input, String) |> rstrip, "\n" => "")
parseSteps(input) = split(joinLines(input), ",")

hashIt(step) = reduce((a, c) -> UInt8(((a + UInt8(c[1])) * 17) % 256), step; init=0)

function solve(steps)
  boxes = [Tuple{String,UInt8}[] for _ in 1:256]
  for s in steps
    (label, focal) = split(s, r"=|-")
    box = boxes[hashIt(label)+1]
    lensIndex = findfirst(lens -> lens[1] == label, box)
    if isempty(focal)
      if !isnothing(lensIndex)
        deleteat!(box, lensIndex)
      end
    else
      t = (label, parse(UInt8, focal))
      if isnothing(lensIndex)
        push!(box, t)
      else
        box[lensIndex] = t
      end
    end
  end

  return sum([b * l * lens[2] for (b, box) in enumerate(boxes) for (l, lens) in enumerate(box)])
end

println("power: ", stdin |> parseSteps |> solve |> sum)

