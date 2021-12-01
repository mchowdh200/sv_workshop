#!/bin/env bash

gaps=$1
high_cov=$2
output=$3

# concat the gaps bed and the high cov regions bed,
# sort by region, then merge regions if they are within
# 100 base pairs of each other
cat $gaps <(cut -f1-3 $high_cov) |
    bedtools sort -i stdin |
    bedtools merge -d 100 -i stdin > $output
