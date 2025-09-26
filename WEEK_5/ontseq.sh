# Week 5 assignment part 3- downloading a seperate sequencing dataset of Stapphylococcus aureus from SRA

# Exit on error, print commands, and treat unset variables as errors
set -xeu

Bioproject= PRJNA976947
SRA=SRR24781619

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