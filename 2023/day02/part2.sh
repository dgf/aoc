#!/bin/sh
#
cat ${1:-example.txt} |
  awk -f part2.awk |
  awk '{s+=$0} END {print s}'
