#!/usr/bin/env awk -f
#

function needsTailMove() {
  if (hx == tx && hy == ty) return 0 # same position
  if (hx == tx && (hy - 1 == ty || hy + 1 == ty)) return 0 # same X and one Y
  if ((hx - 1 == tx || hx + 1 == tx) && hy == ty) return 0 # same Y and one X
  if ((hx - 1 == tx || hx + 1 == tx) && hy - 1 == ty) return 0 # diagonal bottom left right
  if ((hx - 1 == tx || hx + 1 == tx) && hy + 1 == ty) return 0 # diagonal top left right
  return 1
}

function markTailPosition() {
  tail[tx"x"ty] = 1
}

BEGIN {
  hx = 1
  hy = 1
  tx = 1
  ty = 1
  markTailPosition()
}

/^R/ {
  for (r = int($2); r > 0; r--) {
    hx++
    if (needsTailMove()) {
      tx = hx - 1
      ty = hy
      markTailPosition()
    }
  }
}

/^U/ {
  for (u = int($2); u > 0; u--) {
    hy++
    if (needsTailMove()) {
      tx = hx
      ty = hy - 1
      markTailPosition()
    }
  }
}

/^L/ {
  for (l = int($2); l > 0; l--) {
    hx--
    if (needsTailMove()) {
      tx = hx + 1
      ty = hy
      markTailPosition()
    }
  }
}

/^D/ {
  for (d = int($2); d > 0; d--) {
    hy--
    if (needsTailMove()) {
      tx = hx
      ty = hy + 1
      markTailPosition()
    }
  }
}

END {
  print "count: " length(tail)
}

