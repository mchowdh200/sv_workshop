#!/bin/env bash

# merge our 2 sample vcfs into a single set of sites
# which will later be regenotyped
vcfA=$1
vcfB=$2
fasta=$4
outdir=$3

smoove merge --name merged \
       --fasta $fasta \
       --outdir $outdir \
       $vcfA $vcfB
