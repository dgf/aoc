#!/usr/bin/awk -F: -f
#
/Time:/ {
  sub(/^ +/, "", $2)
  split($2, times, / +/)
}

/Distance:/ {
  sub(/^ +/, "", $2)
  split($2, dists, / +/)
}

END {
  for (t = 1; t <= length(times); t++) {
    time = times[t]
    dist = dists[t]
    wins[t] = 0
    for (ms = time - 1; ms > 0; ms--) {
      mm = (time - ms) * ms
      if (mm > dist) wins[t]++
    }
  }

  total = 1
  for (w in wins) total *= wins[w]
  print "total: " total
}

