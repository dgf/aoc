#!/usr/bin/awk -F, -f
#
{
  split($1, lns, "-")
  split($2, rns, "-")

  delete left
  delete right

  for (l = lns[1]; l <= lns[2]; l++) left[l] = 1

  for (r = rns[1]; r <= rns[2]; r++) {
    right[r] = 1
    if (left[r] == 1) left[r] = 2
  }

  for (l = lns[1]; l <= lns[2]; l++)
    if (right[l] == 1) right[l] = 2

  doubleLeft = 1
  doubleRight = 1

  for (l in left) if (left[l] == 1) doubleLeft = 0
  for (r in right) if (right[r] == 1) doubleRight = 0
  if (doubleLeft || doubleRight) pairs += 1
}

END {
  print "pairs: " pairs
}

