#!/usr/bin/awk -f
#
/seeds:/ {
  split($0, init, ":")
  split(init[2], conf, " ")
  for (c = 1; c <= length(conf); c += 2)
    seeds[int(conf[c])] = int(conf[c + 1])
}

/map:/ {
  delete remaining
  for (s in seeds)
    remaining[int(s)] = int(seeds[s])
}

/^[0-9]/ {
  split($0, mapping, " ")
  dest = int(mapping[1])
  source = int(mapping[2])
  len = int(mapping[3])
  send = source + len - 1

  for (r in remaining) {
    min = int(r)
    count = int(seeds[r])
    max = int(min + count - 1)

    if (min >= source && max <= send) {
      delete seeds[r]
      delete remaining[r]
      seeds[dest + (min - source)] = count
    } else if (min <= source && max >= send) {
      delete seeds[r]
      delete remaining[r]

      inc = send - source + 1
      seeds[dest] = inc

      minOut = source - min
      seeds[min] = minOut
      remaining[min] = minOut

      maxOut = max - send
      seeds[send + 1] = maxOut
      remaining[send + 1] = maxOut
    } else if (min >= source && min <= send && max >= send) {
      delete seeds[r]
      delete remaining[r]

      inc = send - min + 1
      seeds[dest + (min - source)] = inc

      out = count - inc
      seeds[send + 1] = out
      remaining[send + 1] = out
    } else if (min <= source && max >= source && max <= send) { 
      delete seeds[r]
      delete remaining[r]

      inc = max - source + 1
      seeds[dest] = inc

      out = count - inc
      seeds[min] = out
      remaining[min] = out
    }
  }
}

END {
  min = 999999999999
  for (s in seeds)
    if (min > int(s))
      min = int(s)
  print "min: " min
}

