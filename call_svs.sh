#!/bin/env bash

bam=$1
fasta=$2
name=$3
exclude=$4
outdir=$5

### call svs using smoove (lumpy+SVTyper)
# genotyping in this stage also filters out 0/0 genotypes
### paramters
# name: This will be a prefix for results vcf
# fasta: Reference genome
# exclude: The set of regions we compiled earlier.
#          these regions will not be taken into consideration.
# outdir: Output directory
# processes: Number of threads to use.  > 4 will basically have no effect.
#            Its better to parallelize over samples in most cases.   
# genotype: Genotype regions after calling.  We'll be regenotyping later, but
#           this step is useful in order to filter out regions deemed to be 0/0
# noextrafilters: This flag is here strictly for speeding up the demonstration.
#                 Usually better to leave this flag out so that further filtering
#                 is performed to refine the results more.
# bam: The input alignment file
smoove call \
       --name $name \
       --fasta $fasta \
       --exclude $exclude \
       --outdir $outdir \
       --processes 4 \
       --genotype \
       --noextrafilters \
       $bam

