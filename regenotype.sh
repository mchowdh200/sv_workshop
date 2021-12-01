#!/bin/env bash

bam=$1
fasta=$2
name=$3
sites_vcf=$4
outdir=$5

# regenotype the sample bam using the merged sites vcf
# additionally, annotate sites with duphold which provides
# various coverage based metrics which can be used for
# filtering false positive duplications and deletions
smoove genotype --duphold \
       --removepr \
       --processes 4 \
       --fasta $fasta \
       --vcf $sites_vcf \
       --name $name-joint \
       --outdir $outdir \
       $bam
