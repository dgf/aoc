#!/usr/bin/awk -f
#
BEGIN {
  split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", a, "")
  for (n in a) alphas[a[n]] = n
}

{
  split(substr($0, 1, length($0) / 2), left, "")
  split(substr($0, length($0) / 2 + 1), right, "")
  delete cat

  for (l in left) cat[left[l]] = 1

  for (r in right) {
    c = right[r]
    if (cat[c]) prio[FNR] = c
  }
}

END {
  for (p in prio) sum = sum + alphas[prio[p]]
  print "sum: " sum
}

