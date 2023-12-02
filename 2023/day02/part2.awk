#!/usr/bin/awk
#
BEGIN { FS = ":" }
{
  split($2, sets, ";")
  delete maxs
  for (s in sets) {
    split(sets[s], cubes, ",")
    for (c in cubes) {
      split(cubes[c], cube, " ")
      if (maxs[cube[2]] < cube[1]) maxs[cube[2]] = cube[1]
    }
  }
  power = 1
  for (m in maxs) power *= maxs[m]
  print power
}
