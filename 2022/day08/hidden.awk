#!/usr/bin/env awk -f
#
{
  split($0, trees, "")
  for (t in trees) forest[FNR"x"t] = trees[t]
}

function addVisible(line, row) {
  coord = line "x" row
  if (last < forest[coord]) {
    last = forest[coord]
    visible[coord] = 1
  }
}

END {
  for (r = 1; r <= length(trees); r++) {
    last = -1
    for (l = 1; l <= FNR; l++) addVisible(l, r)
  }

  for (r = 1; r <= length(trees); r++) {
    last = -1
    for (l = FNR; l >= 1; l--) addVisible(l, r)
  }

  for (l = 1; l <= FNR; l++) {
    last = -1
    for (r = 1; r <= length(trees); r++) addVisible(l, r)
  }

  for (l = 1; l <= FNR; l++) {
    last = -1
    for (r = length(trees); r >= 1; r--) addVisible(l, r)
  }

  print "total: " length(visible)
}

