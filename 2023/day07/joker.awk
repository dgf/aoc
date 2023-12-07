#!/usr/bin/awk -f
#
BEGIN {
  card["T"] = "10"
  card["J"] = " 1"
  card["Q"] = "12"
  card["K"] = "13"
  card["A"] = "14"
}

function type(cards) {
  j = cards["J"]
  delete cards["J"]

  f = 0
  t = 0
  d = 0
  for (o in occurs) {
    c = occurs[o]
    if (c == 5) return 7
    else if (c == 4) f = 1
    else if (c == 3) t = 1
    else if (c == 2) d += 1
  }

  if (f == 1) return j == 1 ? 7 : 6
  if (t == 1) return j == 2 ? 7 : j == 1 ? 6 : d == 1 ? 5 : 4
  if (d == 2) return j == 1 ? 5 : 3
  if (d == 1) return j == 3 ? 7 : j == 2 ? 6 : j == 1 ? 4 : 2
  return j == 5 ? 7 : j == 4 ? 7 : j == 3 ? 6 : j == 2 ? 4 : j == 1 ? 2 : 1
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

