#!/bin/env bash

bam=$1
fasta=$2
prefix=$3

mosdepth --by 100 --fast-mode --no-per-base --chrom ssa01 \
         --fasta $fasta \
         $prefix \
         $bam
