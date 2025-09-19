 # Week 4 Homework

 ## Group 3: Staphylococcus paper

 ## Identifying accession numbers for the genome and downloading data

 The BioProject ID for the data in this study is PRJNA887926, The Accession number for the reference genome is GCF_000013465.1

    datasets download genome accession GCF_000013465.1          --include genome,gff3,gtf

    unzip -n ncbi_dataset.zip

     efetch -db nuccore -format fasta -id NC_007793.1 > NC_007793.1.fa

 ## Visualizing the genome 

The genome is 2,872,769 nt long.

    seqkit stats NC_007793.1.fa

The GFF has 14 features, with the amount of each feature being:

| Number | Feature          |
|--------|------------------|
| 2858   | CDS              |
| 2846   | gene             |
| 82     | pseudogene       |
| 72     | exon             |
| 52     | tRNA             |
| 16     | rRNA             |
| 13     | riboswitch       |
| 4      | region           |
| 3      | binding_site     |
| 3      | sequence_feature |
| 1      | ncRNA            |
| 1      | RNase_P_RNA      |
| 1      | SRP_RNA          |
| 1      | tmRNA            |



     cat genomic.gff | grep -v '#' | cut -f 3 | sort-uniq-count-rank

The longest gene is ID+gene-SAUSA300_RS07235, called ebh, with a length of 31266nt and its function is to bind to fibronectin, which is importance for adherance in the host. It is also involved in cell wall synthesis. https://journals.asm.org/doi/pdf/10.1128/jb.01366-13


Another gene annotated in this genome is named mfd, with the ID_gene-SAUSA300_RS02585 and its function is to encode the MFD protein that is involved in transcription coupled repair to remove stalled RNA polymerase at DNA damage sites. This is important to the bacterias ability to evolve and gain resistance to antibiotics. https://pmc.ncbi.nlm.nih.gov/articles/PMC7885715/

    cat genomic.gff | grep -v '#' > grep.gff

     awk -F'\t' '$3 == "gene" {print $5-$4+1, $0}' grep.gff | sort -nr | head -1

     awk -F'\t' '$3 == "gene" {print $5-$4+1, $0}' grep.gff | sort -nr | head -20
     
## Genomic Features

The genome of S. aureus subsp. aureus USA300_FPR3757 is very closely packed, with little to no space between the UTR of each gene to the next, and often times without any UTRs between genes. Because of this I would estimate that about 85% of the genome is comprised of coding sequences, with UTRs not included.

<img width="1400" height="486" alt="Screenshot 2025-09-18 234945" src="https://github.com/user-attachments/assets/55ba93df-d077-4505-9383-67a9629cf7ea" />

## Finding alternative genome builds

GCF_000013425.1 is the accession number for Staphylococcus aureus subsp. aureus USA300_TCH595.

GCF_000013425.1 is the accession number for Staphylococcus aureus subsp. aureus USA300_TCH1516.

I think that these two genome builds would be useful in this study because they are both genomes of the most predominant CA-MRSA strain in the world, and it would be useful to check for SNPs or other small differeces that might be variable within the same strain to see if the NaP treatment would cause the same effects in each genome version. The question would be whether small variations in this strain would impact the success of NaP treamtment. It can also be used to ask if we see signs of resistance to NaP in this strain based on SNPs.
