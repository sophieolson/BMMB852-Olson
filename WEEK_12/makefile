# Week 12 assignment- Evaluate alignments across sequencing platforms, Genome in a Bottle

# Making the Makefile more robust
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

#Accession number for the reference genome
ACC ?=GCA_000001405.29


# SRA accession number for the sequencing data
SRR=SRR33291168

# Online Reference for human genome
REF_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz

# Reference genome
REF=refs/${NAME}.fasta.gz


REGION=chr9:8,000,000-10,000,000

BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Dovetail_LinkPrep-ILMN_HG8NP_20250625/HG008-N-P_LinkPrep_20250625_sorted_GRCh38.bam


# Read 1
R1=reads/${SRR}_1.fastq
# Read 2
R2=reads/${SRR}_2.fastq
# BAM file
BAM=bam/${SRR}.bam

# How many reads to download
N=600000

# Organism name
NAME=Homo_sapiens

# Temporary bedgraph file
BG=bedgraph/${SRR}.bg

# BW wiggle file
BW=bigwig/${SRR}.bw

GCF=GCA_000001405.29




# NO CHANGE BELOW THIS LINE

# Obtaining the reference genome of Homo sapiens

genome:
# create the directory for the reference genome
	mkdir -p refs
# download the reference genome
	curl -L ${REF_URL} -o ${REF}



# Create the fasta index
faidx:
	cp ${REF} refs/${NAME}.fa
	samtools faidx refs/${NAME}.fa
	seqkit faidx refs/${NAME}.fa


# Downloading the sequencing data
fastq:
	mkdir -p reads/

	# Directly dump only N reads from SRA without prefetch
	fastq-dump -X ${N} --split-files --outdir reads/ ${SRR}

	# Stats
	if [ -f reads/$(SRR)_2.fastq ]; then \
		seqkit stats reads/$(SRR)_1.fastq reads/$(SRR)_2.fastq; \
	else \
		seqkit stats reads/$(SRR)_1.fastq; \
	fi


#aligning the reads to the reference genome
align:
	# Create the BAM directory
	mkdir -p bam

# Extract the reads for the region of interest.
	samtools view -b ${BAM_URL} ${REGION} > ${BAM}

# Index the BAM file.
	samtools index ${BAM}

# Get statistics on the BAM file.
	samtools flagstat ${BAM}


# Generate bigwig file for visualization
.PHONY: bigwig
bigwig:
	mkdir -p bedgraph/ bigwig/
	LC_ALL=C bedtools genomecov -ibam bam/$(SRR).bam -split -bg | sort -k1,1 -k2,2n > bedgraph/$(SRR).bg
	bedGraphToBigWig bedgraph/$(SRR).bg refs/$(NAME).fa.fai bigwig/$(SRR).bw

# Generate alignment statistics
stats:
	samtools flagstat ${BAM}

# Generate alignment coverage
	samtools coverage ${BAM}



.PHONY: all
# Run full script
all:  fastq align bigwig stats
