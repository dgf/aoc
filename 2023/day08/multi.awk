#!/usr/bin/awk -f
#
/=/ {
  n = substr($0, 1, 3)
  l = substr($0, 8, 3)
  r = substr($0, 13, 3)
  net[n"L"] = l
  net[n"R"] = r
  if (substr(n, 3) == "A") route[++s] = n
}

FNR == 1 {
  split($0, steps, "")
}

END {
  i = 0
  f = 1
  l = length(route)
  while (f <= l)
    for (s = 1; s <= length(steps); s++) {
      i++
      g = steps[s]
      delete new
      for (r = 1; r <= length(route); r++)
        new[r] = route[r]
      for (r = 1; r <= length(new); r++) {
        c = new[r]
        n = net[c""g]
        route[r] = n
        if (substr(n, 3) == "Z") {
          found[f] = i / length(steps)
          f++
        }
      }
      if (i > 2000000) exit
    }

  min = 9999999
  for (f = 1; f <= length(found); f++)
    if (min > found[f])
      min = found[f]

  prod = 1
  for (f in found) prod *= found[f]
  print "result: " prod * length(steps)
}

