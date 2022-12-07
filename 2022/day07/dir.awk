#!/usr/bin/env awk -f

/\$ cd \.\./ {
  delete paths[length(paths)]
}

/\$ cd [^.]/ {
  path = substr($0, 6)
  paths[length(paths) + 1] = path
}

/[0-9]+ [a-z]/ {
  tree = ""
  split($0, stat, " ")
  total += stat[1]
  for (p = 2; p <= length(paths); p++) {
    tree = tree "/" paths[p]
    sizes[tree] += stat[1]
  }
}

END {
  unused = 70000000 - total
  missing = 30000000 - unused
  toDelete = 30000000

  for (s in sizes) {
    size = sizes[s]
    if (size <= 100000) sum += size
    if (size > missing && size < toDelete) toDelete = size
  }

  print "sum: " sum
  print "total: " total
  print "unused: " unused " > missing: " missing
  print "to delete min: " toDelete
}

