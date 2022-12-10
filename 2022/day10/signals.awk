#!/usr/bin/env awk -f
#

BEGIN {
  x = 1
  c = 0
  split("20 60 100 140 180 220", cids, " ")
  for (cid in cids) cycles[cids[cid]] = 1
}

function rem() {
  if (cycles[c] == 1) cycles[c] = x
}

/noop/ {
  c++
  rem()
}

/addx/ {
  c++
  rem()
  c++
  rem()
  split($0, p, " ")
  x += p[2]
}

END {
  for (cid in cids) sum += cids[cid] * cycles[cids[cid]]
  print "sum: " sum
}

