#!/usr/bin/awk -F: -f
#
/Time:/ {
  gsub(/ /, "", $2)
  time = int($2)
}

/Distance:/ {
  gsub(/ /, "", $2)
  dist = int($2)
}

END {
  wins = 0
  for (ms = time - 1; ms > 0; ms--) {
    mm = (time - ms) * ms
    if (mm > dist) wins++
  }
  print "ways: " wins
}

