# Week 5 assignment part 2- downloading a sequencing dataset from the Stapphylococcus aureus paper

# Exit on error, print commands, and treat unset variables as errors
set -xeu

Bioproject= PRJNA887926
SRA=SRR21835896	

# --------No Changes below this line------------

# Downloading the sequencing data from NCBI SRA
bio search $SRA

# making a directory to hold the reads
mkdir -p reads

# Downloading the sequencing reads in fastq format for 10x coverage
fastq-dump -X 28700000 -F --outdir reads --split-files $SRA


# Checking the stats of the first read file
seqkit stats reads/SRR21835896_1.fastq


fastqc reads/SRR21835896_1.fastq 

