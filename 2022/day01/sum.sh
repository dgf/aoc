#!/bin/sh

cat ${1:-example.txt} |
  awk '{if($0){s=s+$0}else{print s;s=0}} END {print s}' |
  sort -gr | uniq | head -3 | awk '{s=s+$0} END {print s}'
