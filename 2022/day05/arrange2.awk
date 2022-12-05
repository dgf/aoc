#!/usr/bin/awk -f
#
BEGIN {
  stackCount = 9
}

/\[/ {
  for (s = 1; s <= stackCount; s++) {
    c = substr($0, 2 + (4 * (s - 1)), 1)
    if (c != " ") stacks[s] = c""stacks[s]
  }
}

/^move/ {
  line = $0
 
  match(line, /[0-9]+/)
  amount = substr(line, RSTART, RLENGTH)
  line = substr(line, RSTART + RLENGTH)

  match(line, /[0-9]+/)
  from = substr(line, RSTART, RLENGTH)
  line = substr(line, RSTART + RLENGTH)
  
  match(line, /[0-9]+/)
  to = substr(line, RSTART, RLENGTH)
  
  toPickFrom = substr(stacks[from], length(stacks[from]) - amount + 1)
  stacks[from] = substr(stacks[from], 1, length(stacks[from]) - amount)
  stacks[to] = stacks[to]toPickFrom
}

END {
  for (s = 1; s <= stackCount; s++)
    tops = tops""substr(stacks[s], length(stacks[s]))
  print "tops: " tops
}

