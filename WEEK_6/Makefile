# Week 6 assignement- Staphylococcus aureus paper

# Making the Makefile more robust
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

#Accession number for the reference genome
ACC=NC_007793.1

# Bioproject ID for the sequencing data
Bioproject= PRJNA887926

# SRA accession number for the sequencing data
SRR=SRR21835896

# Reference genome
REF=refs/${NAME}.fa

# Read 1
R1=reads/${SRR}_1.fastq

# Read 2
R2=reads/${SRR}_2.fastq

# BAM file
BAM=bam/${SRR}.bam

# How many reads to download
N=150000

# Organism name
NAME=Staphylococcus_aureus

# NO CHANGE BELOW THIS LINE

#obtaining the reference genome of Staphylococcus aureus
genome:
# create the directory for the reference genome
	mkdir -p $(dir ${REF})
# download the reference genome
	bio fetch ${ACC} --format fasta > ${REF}
# show the stats of the reference genome
	seqkit stats ${REF}

# Downloading the sequencing data
fastq:
    # Create the reads directory
	mkdir -p $(dir ${R1})

    # Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}

    # Show the stats of the reads
	seqkit stats ${R1} ${R2}

# Index the reference genome
index:
	bwa index ${REF}

# Align the reads to the reference genome
align:
# Make the BAM directory
	mkdir -p $(dir ${BAM})

# Align the reads
	bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM}

# Index the BAM file
	samtools index ${BAM}
	
# Generate alignment statistics
stats:
	samtools flagstat ${BAM}

# Generate alignment coverage
	samtools coverage ${BAM}

