#!/usr/bin/env awk -f
#

/Monkey/ {
  m = int(substr($0, 8))
  inspects[m] = 0
}
/Operation:/ { ops[m] = substr($0, 20) }
/Test: divisible by/ { test[m] = substr($0, 22) }
/If true:/ { ifTrue[m] = substr($0, 30) }
/If false:/ { ifFalse[m] = substr($0, 31) }
/Starting items:/ {
  is = substr($0, 19)
  gsub(/, /, " ", is)
  items[m] = is
}

function calc(cmd) {
  split(cmd, terms, " ")
  if (terms[2] == "+") return terms[1] + terms[3]
  if (terms[2] == "*") return terms[1] * terms[3]
}

END {
  mod = 1
  for (m = 0; m < length(test); m++) mod *= test[m]

  for (r = 0; r < 10000; r++) {
    for (m = 0; m < length(items); m++) {
      split(items[m], oldItems, " ")
      inspects[m] += length(oldItems)
      items[m] = ""
      for (c = 1; c <= length(oldItems); c++) {
        item = int(oldItems[c])
        op = ops[m]
        gsub("old", item, op)

        newItem = calc(op)
        newMonkey = ifFalse[m]
        if (newItem % test[m] == 0) newMonkey = ifTrue[m]
        items[newMonkey] = items[newMonkey]" " (newItem % mod)
      }
    }
  }

  max1 = 0
  max2 = 0
  for (m = 0; m < length(inspects); m++) {
    i = inspects[m]
    if (max1 < i) {
      max2 = max1
      max1 = i
    } else if (max2 < i) {
      max2 = i
    }
  }

  print "business: " max1 * max2
}

