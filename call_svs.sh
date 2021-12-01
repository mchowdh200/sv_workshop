#!/bin/env bash

bam=$1
fasta=$2
name=$3
exclude=$4
outdir=$5

# call svs using smoove (lumpy+SVTyper)
# genotyping in this stage also filters out 0/0 genotypes
smoove call \
       --name $name \
       --fasta $fasta \
       --exclude $exclude \
       --outdir $outdir \
       --processes 4 \
       --genotype \
       $bam

