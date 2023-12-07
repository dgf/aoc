#!/bin/sh

./multi.awk ${1:-example.txt} |
  sort -n -k 1 -k 2 -k 3 -k 4 -k 5 -k 6 |
  awk '{s+=FNR*$8} END {print "wins: " s}'
