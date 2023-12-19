function conidtionalRule(rule)
  condition, target = split(rule, ":")
  rating = parse(Int64, condition[3:end])
  return (; target, rating, category=condition[1], direction=condition[2])
end

function parseWorkflow(line)
  name, rest = split(line, "{")
  rules..., fallback = split(rest[1:end-1], ",")
  return (; name, fallback, rules=map(conidtionalRule, rules))
end

readWorkflows(data) = Dict(w.name => w for w ∈ parseWorkflow.(split(data)))
readData(content) = readWorkflows(split(content, "\n\n")[1])

function applyRule(range, direction, rating)
  rMax, rMin = maximum(range), minimum(range)
  if '<' == direction
    return (accepted=rMin:min(rating - 1, rMax), rejected=max(rating, rMin):rMax)
  end
  return (accepted=max(rating + 1, rMin):rMax, rejected=rMin:min(rating, rMax))
end

function applyWorkflow(workflows, fullRanges)
  subFlows = [(name="in", part=fullRanges)]

  total = 0
  while !isempty(subFlows)
    subFlow = popfirst!(subFlows)

    if subFlow.name == "R"
      continue
    elseif subFlow.name == "A"
      total += reduce((a, v) -> a *= (length(v) == 0 ? 0 : maximum(v) - minimum(v)) + 1, values(subFlow.part); init=1)
      continue
    end

    (; rules, fallback) = workflows[subFlow.name]

    for (; target, category, direction, rating) ∈ rules
      (; accepted, rejected) = applyRule(subFlow.part[category], direction, rating)
      if length(rejected) > 0
        subFlow.part[category] = rejected
      end

      if length(accepted) > 0
        subPart = copy(subFlow.part)
        subPart[category] = accepted
        push!(subFlows, (name=target, part=subPart))
      end
    end

    push!(subFlows, (name=fallback, part=subFlow.part))
  end

  return total
end

part2(content) = applyWorkflow(readData(content), Dict(c => 1:4000 for c ∈ "xmas"))
println("called it: ", part2(read(stdin, String)))

