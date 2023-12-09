function calcSumOfNexts(lines)
  sumOfNexts = 0
  for history in [[parse.(Int, x)] for x in lines]
    while !iszero(history[end])
      push!(history, history[end][begin+1:end] - history[end][begin:end-1])
    end
    sumOfNexts += sum(x[end] for x in history)
  end
  return sumOfNexts
end

lines = split.(readlines(stdin))
println("sum of nexts: ", calcSumOfNexts(lines))
println("sum of prevs: ", calcSumOfNexts([reverse(x) for x in lines]))

