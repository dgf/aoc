#!/usr/bin/awk -f
#
BEGIN {
  rules["A A"] = 1 + 3
  rules["A B"] = 2 + 6
  rules["A C"] = 3 + 0
  rules["B A"] = 1 + 0
  rules["B B"] = 2 + 3
  rules["B C"] = 3 + 6
  rules["C A"] = 1 + 6
  rules["C B"] = 2 + 0
  rules["C C"] = 3 + 3
  rules["A X"] = "A C"
  rules["A Y"] = "A A"
  rules["A Z"] = "A B"
  rules["B X"] = "B A"
  rules["B Y"] = "B B"
  rules["B Z"] = "B C"
  rules["C X"] = "C B"
  rules["C Y"] = "C C"
  rules["C Z"] = "C A"
}

{
  score = score + rules[rules[$0]]
}

END {
  print "score: " score
}
