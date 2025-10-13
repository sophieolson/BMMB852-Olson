# Week 7 assignement- Staphylococcus aureus paper

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

# Temporary bedgraph file
BG=bedgraph/${SRR}.bg

# BW wiggle file
BW=bigwig/${SRR}.bw

GCF=GCF_000009045.1

# NO CHANGE BELOW THIS LINE

#obtaining the reference genome of Staphylococcus aureus
genome:
# create the directory for the reference genome
	mkdir -p $(dir ${REF})
# download the reference genome
	bio fetch ${ACC} --format fasta > ${REF}
# show the stats of the reference genome
	seqkit stats ${REF}
# Download the genome gff using ncbi datasets command line tool
	datasets download genome accession ${GCF} --include gff3
	unzip ncbi_dataset.zip

# Downloading the sequencing data
fastq:
    # Create the reads directory
	mkdir -p $(dir ${R1})

    # Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}
	if [ -f reads/$(SRR)_2.fastq ]; then \
        seqkit stats reads/$(SRR)_1.fastq reads/$(SRR)_2.fastq; \
	else \
        seqkit stats reads/$(SRR)_1.fastq; \
	fi

# Index the reference genome
index:
	bwa index ${REF}

# Align the reads to the reference genome

align:
# Make the BAM directory
	mkdir -p $(dir ${BAM})

# Align the reads
	if [ -f reads/$(SRR)_2.fastq ]; then \
        bwa mem -t 4 refs/Staphylococcus_aureus.fa reads/$(SRR)_1.fastq reads/$(SRR)_2.fastq | samtools sort > bam/$(SRR).bam; \
    else \
        bwa mem -t 4 refs/Staphylococcus_aureus.fa reads/$(SRR)_1.fastq | samtools sort > bam/$(SRR).bam; \
    fi

# Index the BAM file
	samtools index ${BAM}

# Generate bigwig file for visualization
.PHONY: bigwig
bigwig:
# Create the directories for the bedgraph and bigwig files
	mkdir -p bedgraph bigwig
# Generate the bedgraph and bigwig files
	LC_ALL=C bedtools genomecov -ibam bam/$(SRR).bam -split -bg | sort -k1,1 -k2,2n > bedgraph/$(SRR).bg
	bedGraphToBigWig bedgraph/$(SRR).bg refs/Staphylococcus_aureus.fa.fai bigwig/$(SRR).bw

# Generate alignment statistics
stats:
	samtools flagstat ${BAM}

# Generate alignment coverage
	samtools coverage ${BAM}

# Find the position with the highest coverage
	samtools depth bam/$(SRR).bam | sort -k3,3nr | head -1
# Count the number of reads that mapped to the region 1526530-1541662 (the region containing the gene mecA)
	samtools view -c -F 0x10 bam/$(SRR).bam ${ACC}:1526530-1541662

# Run full script
all: genome fastq index align bigwig stats
