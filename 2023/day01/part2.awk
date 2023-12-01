#!/usr/bin/awk
#
BEGIN {
  split("one two three four five six seven eight nine", nums, " ")
}
{
  delete replaces
  for (n = 1; n <= 9; n++) {
    firstMatch = match($0, nums[n] ".+")
    if (firstMatch > 0) replaces[n "_" firstMatch] = 1
    lastMatch = match($0, ".+" nums[n])
    if (lastMatch > 0) replaces[n "_" RSTART + RLENGTH - length(nums[n])] = 1
  }
  line = $0
  for (ri in replaces) {
    split(ri, indizes, "_")
    line = substr(line, 0, indizes[2] - 1) indizes[1] substr(line, indizes[2] + 1)
  }
  print line
}
