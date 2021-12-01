#!/bin/env bash

regions_bed=$1
bam=$2
outdir=$3

# we're gonna take the SV regions from our bed
# with format CHR  START  END  Genotype (tab separated)
# and feed them line by line into samplot using a utility called gargs.
# gargs parses the line using a tab delimiter (by default) and allows
# us to form commands with pieces of the line ({0} for 0th element, etc.)
mkdir -p $outdir
cat $regions_bed |
    sed -e 's/0\/1/het/g' -e 's/1\/1/alt/g'| # change the numeric genotype to het or alt
    ~/bin/gargs -p 1 "samplot plot -c {0} -s {1} -e {2} -t DEL -b $bam \\
                      -o {0}_{1}_{2}_DEL_{3}.png"
                
