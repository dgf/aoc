#!/usr/bin/awk -f
#
/=/ {
  n = substr($0, 1, 3)
  l = substr($0, 8, 3)
  r = substr($0, 13, 3)
  net[n"L"] = l
  net[n"R"] = r
}

FNR == 1 {
  split($0, steps, "")
}

END {
  c = "AAA"
  i = 0
  while (c != "ZZZ") {
    for (s = 1; s <= length(steps) && c != "ZZZ"; s++) {
      i++
      g = steps[s]
      n = net[c""g]
      c = n
    }
  }
  print "steps: " i
}

