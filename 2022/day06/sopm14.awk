#!/usr/bin/env awk -f
BEGIN {
  distinct = 14
}
{
  split($0, chars, "")
  notFound = 1
  for (c = distinct; c <= length(chars) && notFound; c++) { # 4 5 6 7 8 9 ...
    unique = 1
    for (d = distinct - 1; d > 0 && unique; d--) # 3 2 1
      for (n = d - 1; n >= 0 && unique; n--) # 2 1 0
        if (chars[c - d] == chars[c - n])
          unique = 0
    if (unique) {
      print "starts at: " c
      notFound = 0
    }
  }
}

