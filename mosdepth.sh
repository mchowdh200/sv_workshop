#!/bin/env bash

bam=$1
fasta=$2
prefix=$3

# calculate coverage of a bam with mosdepth.
# to speed things up we are using samples with only
# chromosome ssa01.
mosdepth --by 10000 --fast-mode --no-per-base --chrom ssa01 \
         --fasta $fasta \
         $prefix \
         $bam
