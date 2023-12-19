function matchRule(condition, part)
  category, rating = split(condition, r">|<")
  ratingValue = parse(Int64, rating)
  partValue = part[category]
  return '<' in condition ? partValue < ratingValue : partValue > ratingValue
end

function parseRule(rule)
  if ':' ∉ rule
    return (rule, (part) -> true)
  else
    condition, target = split(rule, ":")
    return (target, (part) -> matchRule(condition, part))
  end
end

function parseWorkflow(line)
  name, rest = split(line, "{")
  rules = map(parseRule, split(rest[1:end-1], ","))
  return (name, rules)
end

function readWorkflows(data)
  lines = split(data)
  workflowList = parseWorkflow.(lines)
  wd = Dict(w[1] => w[2] for w ∈ workflowList)
  return wd
end

function parsePart(line)
  cleanedLine = replace(line, "{" => "", "}" => "")
  categoryList = split.(split(cleanedLine, ","), "=")
  pd = Dict(c[1] => parse(Int64, c[2]) for c ∈ categoryList)
  return pd
end

function parseParts(data)
  lines = split(data)
  parts = parsePart.(lines)
  return parts
end

function readData(input)
  data = split(read(input, String), "\n\n")
  return (readWorkflows(data[1]), parseParts(data[2]))
end

function process(workflows, part)
  n = "in"
  i = 0
  while !isempty(n) && i < 9
    for (t, c) ∈ workflows[n]
      if c(part)
        if t == "R"
          return 0
        elseif t == "A"
          return sum(values(part))
        end
        n = t
        break
      end
    end
    i += 1
  end
  println(">>>>>>>>> UNMATCHED !!!!! $part")
  return 0
end

workflows, parts = readData(stdin)
allParts = 0
for part in parts
  global allParts += process(workflows, part)
end
println("all: $allParts")

