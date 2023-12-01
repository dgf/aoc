#!/bin/sh

cat ${1:-example2.txt} |
  awk -f part2.awk |
  sed 's/[a-z]//g' |
  awk '{n=split($0,a,""); print a[1] a[n]}' |
  awk '{s+=$0} END {print s}'
