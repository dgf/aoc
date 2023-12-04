#!/usr/bin/awk -F: -f
#
{
  winSum = 0
  delete wins
  delete haves

  split($2, parts, "|")
  split(parts[1], winsByIndex, " ")
  split(parts[2], haves, " ")
  for (w in winsByIndex) wins[winsByIndex[w]] = 1
  for (h in haves) wins[haves[h]] += 1
  for (w in wins) if (wins[w] == 2) winSum += 1

  if (winSum)
    for (l = 1; l <= winSum; l++)
      copies[FNR + l] += 1 + copies[FNR]
}

END {
  sum = FNR
  for (c = 2; c <= FNR; c++) sum += copies[c]
  print "sum: " sum
}

