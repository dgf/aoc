#!/usr/bin/awk -F, -f
#
{
  split($1, lns, "-")
  split($2, rns, "-")

  delete left
  delete right

  overlaps = 0

  for (l = lns[1]; l <= lns[2]; l++) left[l] = 1
  
  for (r = rns[1]; r <= rns[2]; r++) {
    right[r] = 1
    if (left[r] == 1) overlaps = 1
  }

  for (l = lns[1]; l <= lns[2]; l++) if (right[l] == 1) overlaps = 1
  if (overlaps) sum += 1
}

END {
  print "overlaps: " sum
}

