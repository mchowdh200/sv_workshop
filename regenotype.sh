#!/bin/env bash

bam=$1
fasta=$2
name=$3
sites_vcf=$4
outdir=$5

### regenotype the sample bam using the merged sites vcf
# additionally, annotate sites with duphold which provides
# various coverage based metrics which can be used for
# filtering false positive duplications and deletions
### Params
# duphold - runs duphold tool which computes various coverage based
#           metrics for each region.  Usefull for filtering false positive
#           deletions and duplications
# removepr - lumpy (the sv caller) outputs probability distributions for each
#            sv breakpoint (as vectors of floating point numbers).  These vectors
#            make it pretty hard for humans to read the contents of a vcf.  This
#            flag omits these distributions.
# processes - number of processes to use
# fasta - reference genome
# vcf - our previously merged vcf
# name - prefix for output files
# outdir - output directory
# bam - the alignment file for the sample we wish to genotype
smoove genotype --duphold \
       --removepr \
       --processes 4 \
       --fasta $fasta \
       --vcf $sites_vcf \
       --name $name-joint \
       --outdir $outdir \
       $bam
