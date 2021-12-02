#!/bin/env bash

## get high cov regions
###############################################################################

data_dir=~/work/data
mkdir -p $data_dir/mosdepth
# bash mosdepth.sh $data_dir/XH82_ssa01.bam \
#      $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#      $data_dir/mosdepth/XH82

# bash mosdepth.sh $data_dir/XH96_ssa01.bam \
#      $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#      $data_dir/mosdepth/XH96

mkdir -p $data_dir/high_cov
# python get_high_cov.py $data_dir/mosdepth/XH82.regions.bed.gz \
#                        $data_dir/high_cov/XH82.high_cov.bed
# python get_high_cov.py $data_dir/mosdepth/XH96.regions.bed.gz \
#                        $data_dir/high_cov/XH96.high_cov.bed

## get reference gaps
###############################################################################
mkdir -p $data_dir/gaps
# python gap_regions.py $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz 8 |
#     grep ssa01 > $data_dir/gaps/gap_regions.ssa01.bed

## generate exclude regions
###############################################################################
mkdir -p $data_dir/exclude
# cat $data_dir/gaps/gap_regions.ssa01.bed \
#     <(cut -f1-3 $data_dir/high_cov/XH82.high_cov.bed) \
#     <(cut -f1-3 $data_dir/high_cov/XH96.high_cov.bed) |
#     bedtools sort -i stdin |
#     bedtools merge -d 1000 -i stdin > $data_dir/exclude/exclude.bed


## call Svs with smoove (lumpy/SVTyper)
###############################################################################
mkdir -p $data_dir/XH82
mkdir -p $data_dir/XH96
# bash call_svs.sh $data_dir/XH82_ssa01.bam \
#     $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#     XH82 \
#     $data_dir/exclude/exclude.bed \
#     $data_dir/XH82
# bash call_svs.sh $data_dir/XH96_ssa01.bam \
#     $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#     XH96 \
#     $data_dir/exclude/exclude.bed \
#     $data_dir/XH96

## merge sites from two samples
###############################################################################
mkdir -p $data_dir/merged
# smoove merge --name merged \
#     --fasta $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#     --outdir $data_dir/merged \
#     $data_dir/XH82/XH82-smoove.genotyped.vcf.gz \
#     $data_dir/XH96/XH96-smoove.genotyped.vcf.gz


## regenotype the samples from the sites vcf
###############################################################################
# bash regenotype.sh $data_dir/XH82_ssa01.bam \
#     $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#     XH82 \
#     $data_dir/merged/merged.sites.vcf.gz \
#     $data_dir/XH82

# bash regenotype.sh $data_dir/XH96_ssa01.bam \
#     $data_dir/GCF_000233375.1_ICSASG_v2_genomic.fa.gz \
#     XH96 \
#     $data_dir/merged/merged.sites.vcf.gz \
#     $data_dir/XH96

## combine vcfs into final result
###############################################################################
# smoove paste --name final --outdir $data_dir \
#     $data_dir/XH82/XH82-joint-smoove.genotyped.vcf.gz \
#     $data_dir/XH96/XH96-joint-smoove.genotyped.vcf.gz


## for a single sample get all dels with het or hom alt genotype and put into bed format
###############################################################################
# bcftools query -s XH82 -i 'SVTYPE="DEL"' \
#     -f '%CHROM\t%POS\t%INFO/END\t[%GT]\n' \
#     $data_dir/final.smoove.square.vcf.gz |
#     grep -v '0/0' | grep -v '\./\.' > $data_dir/XH82.del.bed

## Generate some samplot images for visualizations
###############################################################################
# bash samplot_plot.sh $data_dir/XH82.del.bed \
#     $data_dir/XH82_ssa01.bam \
#     $data_dir/XH82_images \
#     4


## Use samplot-ml to annotate
###############################################################################
# cd to samplot-ml working directory
# snakemake -s samplot-ml-predict.smk -j 4 --use-conda --conda-frontend mamba



