#!/bin/sh
#
cat ${1:-example.txt} |
  awk -f part1.awk |
  awk '{s+=$0} END {print s}'
