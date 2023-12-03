#!/bin/sh
#
cat ${1:-example.txt} |
  awk -f part2.awk
