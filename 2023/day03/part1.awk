#!/usr/bin/awk
#
{
  numberLineIndex = 0
  numberLineString = $0
  while (length(numberLineString)) {
    foundNumber = match(numberLineString, /[0-9]+/)
    if (foundNumber == 0) {
      numberLineString = ""
    } else {
      numberValue = substr(numberLineString, RSTART, RLENGTH)
      numberStart = numberLineIndex + RSTART
      numberLineIndex += RSTART + RLENGTH - 1
      numberLineString = substr(numberLineString, RSTART + RLENGTH)
      for (i = numberStart; i <= numberLineIndex; i++)
        parts[FNR "_" i] = numberValue
    }
  }

  symbolLineString = $0
  symbolLineIndex = 0
  while (length(symbolLineString)) {
    foundSymbol = match(symbolLineString, /[^.0-9]/)
    if (foundSymbol == 0) {
      symbolLineString = ""
    } else {
      symbolValue = substr(symbolLineString, RSTART, 1)
      symbolLineIndex += RSTART
      symbolLineString = substr(symbolLineString, RSTART + 1)
      symbols[FNR "_" symbolLineIndex] = symbolValue
    }
  }
}

END {
  sum = 0
  for (s in symbols) {
    split(s, coord, "_")
    line = coord[1]
    pos = coord[2]
    for (l = line - 1; l <= line + 1; l++) {
      for (i = pos - 1; i <= pos + 1; i++) {
        value = parts[l "_" i]
        if (value) {
          sum = sum + value
          for (d = i - length(value); d <= i + length(value); d++)
            if (parts[l "_" d] == value)
              delete parts[l "_" d]
        }
      }
    }
  }

  print "sum: " sum
}

