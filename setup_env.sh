#!/bin/env bash

# we could have installed this with conda as well
sudo apt install -y bedtools

# mamba is a drop in replacement for the conda package manager.
# Conda can get quite slow when trying to figure out the dependencies
# of a package you're trying to install.  Mamba is much quicker.
conda install -y -c conda-forge mamba

## Conda environments
# When installing dependencies for tools its best to keep everyting
# siloed off as much as possible so that you don't run into conflicting
# package versions.  This does mean you have to switch conda environments
# between certain steps, but in practice you would let a workflow management
# system like Nextflow or Snakmake take care of that for you.

# mosdepth is a tools for quickly and accurately computing depth
# of coverage in alignement files.
mamba create -y -c bioconda -n mosdepth mosdepth

# a simple python 3 environment for doing some simple number crunching
mamba create -y -n pandas python=3.9 pandas

# environment used when computing reference gaps
# biopython allows us to easily iterate over fasta records.
# joblib is used for parallelization.
mamba create -y -c bioconda -c conda-forge -n biopython biopython joblib

# smoove is a suite of tools used for SV calling
# Its important that a package like this gets its own environment
# because it still relies upon python 2.  Everything else is
# probably safe to put in a single python 3 based environment.
mamba create -y -c bioconda -n smoove smoove

# samplot generates visualizations of genomic regions
# which we can use to examine our SV calls
mamba create -y -c bioconda -n samplot samplot

# snakemake is a workflow management tools that allows
# us to take many of the things we learn about today and compose
# them into easy to run/reproduce data pipelines.
mamba create -y -c bioconda -c conda-forge -n snakemake python=3.9 snakemake
