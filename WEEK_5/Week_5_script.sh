# Week 5 Script - Dowloading FASTA and GFF files from NCBI Datasets for Staphylococcus aureus genome
# Creating a Bash script with Week 4 commands

# Exit on error, print commands, and treat unset variables as errors
set-xeu 

ACC=GCF_000013465.1
FASTA=ncbi_dataset/data/GCF_000013465.1/GCF_000013465.1_ASM1346v1_genomic.fna
GFF=ncbi_dataset/data/GCF_000013465.1/GCF_000013465.1_ASM1346v1_genomic.gff 

#------------ No Changes below this line------------

# Downloading Staphylococcus genome data from NCBI Datasets
datasets download genome accession $ACC          --include genome,gff3,gtf

# Unzip the downloaded file
unzip -n ncbi_dataset.zip

# Check the contents of the unzipped directory
seqkit stats $FASTA

# Extract and sort unique feature types from the GFF file
 cat $GFF | grep -v '#' | cut -f 3 | sort-uniq

# Remove comment lines from the GFF file and save to a new file
 cat $GFF | grep -v '#' > grep.gff

# Find the longest gene in the GFF file
 awk -F'\t' '$3 == "gene" {print $5-$4+1, $0}' grep.gff | sort -nr | head -1

# Find the top 20 longest genes in the GFF file
 awk -F'\t' '$3 == "gene" {print $5-$4+1, $0}' grep.gff | sort -nr | head -20
