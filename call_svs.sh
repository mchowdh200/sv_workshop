#!/bin/env bash

bam=$1
name=$2
exclude=$3
outdir=$4

# call svs using smoove (lumpy+SVTyper)
smoove call \
       --name $name \
       --exclude $exclude \
       --processes 4 \
       --genotype \
       --removepr \
       $bam

