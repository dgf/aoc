#!/usr/bin/env awk -f
{
  split($0, chars, "")
  notFound = 1
  for (c = 4; c <= length(chars); c++)
    if (notFound &&
        chars[c-3] != chars[c-2] &&
        chars[c-3] != chars[c-1] &&
        chars[c-3] != chars[c] &&
        chars[c-2] != chars[c-1] &&
        chars[c-2] != chars[c] &&
        chars[c-1] != chars[c]) {
      print "starts at: " c
      notFound = 0
    }
}

