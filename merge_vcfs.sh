#!/bin/env bash

# merge our 2 sample vcfs into a single set of sites
# which will later be regenotyped
vcfA=$1
vcfB=$2
fasta=$3
outdir=$4

smoove merge --name merged \
       --fasta $fasta \
       --outdir $outdir \
       $vcfA $vcfB
