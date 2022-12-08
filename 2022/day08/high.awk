#!/usr/bin/env awk -f
#
{
  split($0, trees, "")
  for (t in trees) forest[FNR"x"t] = trees[t]
}

END {
  for (l = 1; l <= FNR; l++)
    for (r = 1; r <= length(trees); r++) {
      f = l"x"r
      t = forest[f]

      go = 1
      right = 0
      for (x = r + 1; x <= length(trees) && go; x++) {
        if (forest[l"x"x] < t) right++
        if (forest[l"x"x] >= t) { right++; go = 0 }
      }

      go = 1
      left = 0
      for (x = r - 1; x >= 1 && go; x--) {
        if (forest[l"x"x] < t) left++
        if (forest[l"x"x] >= t) { left++; go = 0 }
      }

      go = 1
      bottom = 0
      for (x = l + 1; x <= FNR && go; x++) {
        if (forest[x"x"r] < t) bottom++
        if (forest[x"x"r] >= t) { bottom++; go = 0 }
      }

      go = 1
      top = 0
      for (x = l - 1; x >= 1 && go; x--) {
        if (forest[x"x"r] < t) top++
        if (forest[x"x"r] >= t) { top++; go = 0 }
      }

      score = left * right * bottom * top
      if (score > max) max = score
    }

  print "max score: " max
}

