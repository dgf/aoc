#!/usr/bin/awk -f
#
{
  if ($0) {
    sum = sum + $0
  } else {
    if (sum > max) {
      max = sum
    }
    sum = 0
  }
}
END {
  print "max: " max
}
