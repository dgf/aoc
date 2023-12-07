#!/usr/bin/awk -f
#
BEGIN {
  card["T"] = 10
  card["J"] = 11
  card["Q"] = 12
  card["K"] = 13
  card["A"] = 14
}

function type(cards) {
  t = 0
  d = 0
  for (o in occurs) {
    c = occurs[o]
    if (c == 5) return 7
    else if (c == 4) return 6
    else if (c == 3) t = 1
    else if (c == 2) d += 1
  }

  if (t == 1) return d == 1 ? 5 : 4
  if (d == 2) return 3
  if (d == 1) return 2
  return 1
}

function map(n) {
  m = card[n]
  return m ? m : " " n
}

// {
  split($1, cards, "")
  delete occurs
  numbered = ""
  for (c = 1; c <= length(cards); c++) {
    n = cards[c]
    occurs[n] += 1
    numbered = numbered " " map(n)
  }
  print type(occurs) " " numbered " " $1 " " $2
}

