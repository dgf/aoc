#!/usr/bin/awk
#
BEGIN {
  FS = ":"
  bag["red"] = 12; bag["green"] = 13; bag["blue"] = 14
}
{
  split($1, game, " ")
  split($2, sets, ";")
  fits = 1
  for (s in sets) {
    split(sets[s], cubes, ",")
    for (c in cubes) {
      split(cubes[c], cube, " ")
      if (bag[cube[2]] < cube[1]) fits = 0
    }
  }
  if (fits) print game[2]
  else print "0"
}
