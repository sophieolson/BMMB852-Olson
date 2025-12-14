## Week 14- Differential expression analysis on an RNA-Seq count matrix

The goal of this assingment is to run a complete RNA-seq analysis based on the staphylococcus paper to identify the genes that are differentially expressed in the control samples vs the test sample.

## Operating the makefile


The make file first includes commands to download the Staphlyococcus aureus reference genome where the BAM files will align to. Because the bam alignments rely on the refrence genome, the genome has to be acquired before the next steps. Therefore run:

    make genome ACC=NC_007793.1
    make index
    make faidx

Other actions within the make file include: fastq align bigwig stats 

each can be run indiviually, but they are also all listed under the action all, so as described in th enext section, all actions will be set to run at the same time. 

fastq downloads the SRR sequencing data into fastq files.

align takes the fastq files adn aligns them to the reference genome.

bigwig creates bw files to better visualize the coverage of sequencing in IGV

stats gives information such as how well the sequencing files aligned to the reference genome and how much coverage they have. 

6 samples are included in this paper, 3 controls, and 3 sodium propionate added samples, the design.csv attached in this folder lists all samples and their SRRs

    cat design.csv |     parallel --colsep , --header : --eta --lb -j 2         make SRR={SRR} SAMPLE={SAMPLE} GROUP={GROUP} all



## Running feature counter and creating count matrix

To run feature counter use:

    make counts

To compile the matrices together into a single file use:

    make matrix

## making a PCA plot and Heat map

This command does three things, uses Edger to count how many significant FDRs there are. PCA and heatmaps are then made comparing the gene expressions of each sample.

    make edger

The Edger script found that there are 567 genes that are significantly differentially expressed

    Group Control has 3 samples.
    Group SodiumPropionate has 3 samples.
    Method: glm
    Input: 2811 rows
    Removed: 1481 rows
    Fitted: 1330 rows
    Significant PVal:  659 ( 49.50 %)
    Significant FDRs:  567 ( 42.60 %)

PCA plot shows that the control group clusters together and the test group clusters, indicating that there will be differences in gene expression between the two groups

<img width="826" height="386" alt="Screenshot 2025-12-13 214658" src="https://github.com/user-attachments/assets/f6794805-1d4b-4722-ac59-192ded6bf73b" />


Heat map shows the relative expression of each gene for each of the six samples. Many areas in the heat map appear to be very dark indicating that the difference in expression is not very large.


<img width="681" height="766" alt="Screenshot 2025-12-13 214913" src="https://github.com/user-attachments/assets/6ebddef5-3c62-4911-beeb-926b8930897f" />

## Identifying differentially expressed genes anf Functional Analysis

Earlier we see that there are 567 differentially expressed genes which is too many to analyze. To look at the top five differentially expressed genes use:

    make result

This identified the top five genes as

    gene-SAUSA300_RS01370
    gene-SAUSA300_RS08885
    gene-SAUSA300_RS05720
    gene-SAUSA300_RS01365
    gene-SAUSA300_RS13060

For functional analysis studies, I attempted to use both g:Prolifer and Enricher, but I had many issues with the model system of this paper: staphylococcus aureus. Because of this road block, I instead searched for each gene individually on websites like UniProt to determine their functions. 

gene-SAUSA300_RS01370- no functional role is known for this protein


gene-SAUSA300_RS08885- Essential part of translation machinery where changes could affect protein synthesis efficiency or stress response.


gene-SAUSA300_RS05720- A major virulence factor that contributes to cytotoxicity and immune evasion, often upregulated in invasive infections.


gene-SAUSA300_RS01365- no functional role is known for this protein


gene-SAUSA300_RS13060- no functional role is known for this protein
