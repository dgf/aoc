#!/usr/bin/env awk -F, -f
#
{
  split($1, l, "-")
  split($2, r, "-")

  if (l[1] <= r[1] && l[2] >= r[2] || r[1] <= l[1] && r[2] >= l[2]) p += 1
}

END {
  print "pairs: " p
}
