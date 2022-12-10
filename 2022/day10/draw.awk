#!/usr/bin/env awk -f
#

BEGIN {
  x = 1
  c = 0
}

function draw() {
  l = int(c / 40) + 1
  r = c % 40
  s = "."
  if (x - 1 <= r && r <= x + 1) s = "#"
  d[l"x"r] = s
}

/noop/ {
  draw()
  c++
}

/addx/ {
  draw()
  c++
  draw()
  c++
  split($0, p, " ")
  x += p[2]
}

END {
  for (l = 1; l <= 6; l++) {
    for (r = 0; r < 40; r++) printf "%s", d[l"x"r]
    print ""
  }
}

