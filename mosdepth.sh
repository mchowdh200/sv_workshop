#!/bin/env bash

# path to alignment file
bam=$1

# path to the reference genome
fasta=$2

# output files will have this prefix.
# for example if the prefix is AAA/BBB, then the output files
# will be located in a directory AAA and have prefix of BBB
prefix=$3

# calculate coverage of a bam with mosdepth.
# to speed things up we are using samples with only
# chromosome ssa01.
#
# mosdepth can calculate bam coverage quickly and accurately at
# a per-base resolution. For our purposes we only need to find
# regions with high coverage, so we can sacrifice some resolution
# and accuracy for a pretty hefty speed boost.
mosdepth --by 10000 --fast-mode --no-per-base --chrom ssa01 \
         --fasta $fasta \
         $prefix \
         $bam
