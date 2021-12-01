#!/bin/env bash

bam=$1
fasta=$2
name=$3
exclude=$4
outdir=$5

# call svs using smoove (lumpy+SVTyper)
smoove call \
       --name $name \
       --fasta $fasta \
       --exclude $exclude \
       --processes 4 \
       --genotype \
       --removepr \
       $bam

