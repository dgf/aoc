#!/usr/bin/env awk -F, -f
#
{
  split($1, l, "-")
  split($2, r, "-")

  if (l[2] >= r[1] && l[1] <= r[2]) o += 1
}

END {
  print "overlaps: " o
}

