#!/usr/bin/env awk -f
#
BEGIN {
  split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", a, "")
  for (n in a) alphas[a[n]] = n
}

{
  split($0, items, "")
  delete cat

  for (i in items) cat[items[i]] = 1
  for (c in cat) grp[c] += 1

  if (FNR % 3 == 0) {
    for (g in grp) if (grp[g] == 3) prio[FNR] = g
    delete grp
  }
}

END {
  for (p in prio) sum += alphas[prio[p]]
  print "sum: " sum
}

