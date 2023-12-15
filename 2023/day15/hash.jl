joinLines(input) = replace(read(input, String) |> rstrip, "\n" => "")
replaceByAsciis(s) = map(c -> Int(c[1]), split(s, ""))
parseSteps(input) = map(replaceByAsciis, split(joinLines(input), ","))
solve(step; multi=17) = reduce((a, c) -> ((a + c) * multi) % 256, step; init=0)

println("sum: ", stdin |> parseSteps .|> solve |> sum)

