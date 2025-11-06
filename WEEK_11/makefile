# Week 10 assignment- Adding variant calling to Week 9 Makefile

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
SRR=

# Reference genome
REF=refs/${NAME}.fa


# Read 1
R1=reads/${GROUP}/${SAMPLE}/${SAMPLE}_${SRR}_1.fastq
# Read 2
R2=reads/${GROUP}/${SAMPLE}/${SAMPLE}_${SRR}_2.fastq
# BAM file
BAM=bam/${GROUP}/${SAMPLE}/${SAMPLE}_${SRR}.bam

# How many reads to download
N=150000

# Organism name
NAME=Staphylococcus_aureus

# Temporary bedgraph file
BG=bedgraph/${SRR}.bg

# BW wiggle file
BW=bigwig/${GROUP}/${SAMPLE}/${SRR}.bw

GCF=GCF_000009045.1

# name of sample from design file
SAMPLE=

#Type of sample from design file
GROUP=

# Flags for the mpileup command
F1=-d 100 --annotate 'INFO/AD,FORMAT/DP,FORMAT/AD,FORMAT/ADF,FORMAT/ADR,FORMAT/SP'

# Flags for the call command
F2=--ploidy 2 --annotate 'FORMAT/GQ'

VCF=vcf/${GROUP}/${SAMPLE}/${SAMPLE}_${SRR}.vcf.gz

# NO CHANGE BELOW THIS LINE

#obtaining the reference genome of Staphylococcus aureus

#obtaining the reference genome of Staphylococcus aureus

genome:
# create the directory for the reference genome
	mkdir -p refs
# download the reference genome
	bio fetch ${ACC} --format fasta > ${REF}
# show the stats of the reference genome
	seqkit stats ${REF}
# Download and extract the correct GFF for Staphylococcus aureus
	bio fetch ${ACC} -format gff > refs/${NAME}.gff


# Index the reference genome
index:
	bwa index ${REF}

# Create the fasta index
faidx:
	samtools faidx refs/Staphylococcus_aureus.fa


# Downloading the sequencing data
fastq:
	# Create the reads directory
	mkdir -p reads/$(GROUP)/$(SAMPLE)

	# Download the reads
	fastq-dump -X ${N} --outdir reads/$(GROUP)/$(SAMPLE) --split-files $(SRR)
	# Rename output files to include sample name
	if [ -f reads/$(GROUP)/$(SAMPLE)/$(SRR)_2.fastq ]; then \
		mv reads/$(GROUP)/$(SAMPLE)/$(SRR)_1.fastq reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq; \
		mv reads/$(GROUP)/$(SAMPLE)/$(SRR)_2.fastq reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_2.fastq; \
		seqkit stats reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_2.fastq; \
	else \
		mv reads/$(GROUP)/$(SAMPLE)/$(SRR)_1.fastq reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq; \
		seqkit stats reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq; \
	fi



# Align the reads to the reference genome
align:
# Make the BAM directory
	mkdir -p $(dir ${BAM})

# Align the reads
	if [ -f reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_2.fastq ]; then \
		bwa mem -t 4 refs/Staphylococcus_aureus.fa reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_2.fastq | samtools sort > bam/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bam; \
	else \
		bwa mem -t 4 refs/Staphylococcus_aureus.fa reads/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR)_1.fastq | samtools sort > bam/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bam; \
	fi

# Index the BAM file
	samtools index ${BAM}


# Generate bigwig file for visualization
.PHONY: bigwig
bigwig:
	mkdir -p bedgraph/$(GROUP)/$(SAMPLE) bigwig/$(GROUP)/$(SAMPLE)
	LC_ALL=C bedtools genomecov -ibam bam/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bam -split -bg | sort -k1,1 -k2,2n > bedgraph/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bg
	bedGraphToBigWig bedgraph/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bg refs/Staphylococcus_aureus.fa.fai bigwig/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bw

# Generate alignment statistics
stats:
	samtools flagstat ${BAM}

# Generate alignment coverage
	samtools coverage ${BAM}

# Calling variants from the aligned reads
vcf/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).vcf.gz: bam/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(SRR).bam
	mkdir -p vcf/$(GROUP)/$(SAMPLE)
	bcftools mpileup $(F1) -O u -f $(REF) $< | \
	bcftools call $(F2) -mv -O u | \
	bcftools norm -f $(REF) -d all -O u | \
	bcftools sort -O z > $@

vcf: $(foreach srr,$(SRR),vcf/$(GROUP)/$(SAMPLE)/$(SAMPLE)_$(srr).vcf.gz)

# Merge all individual sample VCF files into one multisample VCF

# Index each VCF file after creation
%.vcf.gz.tbi: %.vcf.gz
	bcftools index $<


# Force re-indexing of all VCF files before merging
force_index:
	for f in vcf/*/*/*.vcf.gz; do bcftools index -f "$$f"; done

merge: force_index
	mkdir -p vcf/merged
	bcftools merge vcf/*/*/*.vcf.gz -Oz -o vcf/merged/multisample.vcf.gz

.PHONY: all
# Run full script
all: fastq align bigwig stats vcf 
