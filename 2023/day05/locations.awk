#!/usr/bin/awk -f
#
/seeds:/ {
  split($0, init, ":")
  split(init[2], seeds, " ")
}

/map:/ {
  delete remaining
  for (s in seeds) remaining[s] = 1
}

/^[0-9]/ {
  split($0, mapping, " ")
  dest = mapping[1]
  source = mapping[2]
  len = mapping[3]

  for (r in remaining) {
    value = seeds[r]
    if (source <= value && value < source + len) {
      delete remaining[r]
      seeds[r] = dest + (value - source)
    }
  }
}

END {
  min = seeds[1]
  for (s = 2; s <= length(seeds); s++)
    if (min > seeds[s])
      min = seeds[s]
  print "min: " min
}

