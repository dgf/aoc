comparisons = Dict('<' => <, '>' => >)

function conidtionalRule(rule)
  condition, target = split(rule, ":")
  category, compare, rating = condition[1], comparisons[condition[2]], parse(Int64, condition[3:end])
  return (target, accept=part -> compare(part[category], rating))
end

parseRule(rule) = ':' ∉ rule ? (target=rule, accept=part -> true) : conidtionalRule(rule)

function parseWorkflow(line)
  name, rest = split(line, "{")
  return (name, rules=map(parseRule, split(rest[1:end-1], ",")))
end

readWorkflows(data) = Dict(w.name => w.rules for w ∈ parseWorkflow.(split(data)))

# part parsing
trimBrackets(line) = replace(line, "{" => "", "}" => "")
parseCategory(category) = (name=category[1], rating=parse(Int64, category[3:end]))
parsePart(line) = Dict(c.name => c.rating for c ∈ parseCategory.(split(trimBrackets(line), ",")))

# read and map file
mapDataSections((w, c)) = (workflows=readWorkflows(w), parts=parsePart.(split(c)))
readData(input) = mapDataSections(split(read(input, String), "\n\n"))

function process(workflows, part)
  n = "in"
  breaker = 0
  while !isempty(n) && breaker < 9
    for rule ∈ workflows[n]
      if rule.accept(part)
        if rule.target == "R"
          return 0
        elseif rule.target == "A"
          return sum(values(part))
        end
        n = rule.target
        break
      end
    end
    breaker += 1
  end
  println(">>>>>>>>> UNMATCHED $breaker !!!!! $part")
  return 0
end

factory = readData(stdin)
allParts = sum(map(p -> process(factory.workflows, p), factory.parts))
println("all: $allParts")

