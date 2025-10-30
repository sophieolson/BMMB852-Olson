## Week 8 Assignment

This assignment is based off of the methicillin-resistant Staphylococcus aureus paper and its RNA-seq data. The bioproject for this sequencing data is:

Bioproject= PRJNA887926

## Identifying samples and SRR numbers of RNA sequencing

To identify the number and identiy of samples used in the Staphylococcus aureus paper, the below code was used:

    bio search PRJNA887926 -H --csv > metadata.csv

This resulted in 6 RNA-seq samples, 3 control samples, and 3 experimental samples that had sodium proponoiate added. 

I created a design.csv file that contains information for sample, SRR, and group of each of the six samples, and is attached in this folder. Sample defines which sample number it is: 1-6, and group defines if it is a control or an experimental sample. 

## Creating a Makefile to produce multiple BAM files

The make file first includes commands to download the Staphlyococcus aureus refreence genome where the BAM files will align to. Because the bam alignments rely on the refrence genome, the genome has to be acquired before the next steps. Therefore run:

    make genome ACC=NC_007793.1
    make index
    make faidx

Now the remainder of the Make file can be run using make all, as all contains fastq, align, bigwig, and stats. 

## Using GNU parallel run on the Makefile

Because there are very few samples attached to this paper, I chose to run my parallel as J 2, but j 3 can also be used. The code below uses the names and SRRs listed in my design.csv file and runs them two at a time through the make file to make fastq file, align them to the reference genome, convert them to bigwig files, then give statistics as to the quality of the algnments.

     cat design.csv |     parallel --colsep , --header : --eta --lb -j 2         make SRR={SRR} SAMPLE={SAMPLE} GROUP={GROUP} all

## Stats of FASTQs and alignments

User friendly genome name:


Staphylococcus_aureus.fa

FastQ read data named by the samples:

Sample1_SRR21835898_1.fastq

Sample2_SRR21835897_1.fastq

Sample3_SRR21835896_1.fastq

Sample4_SRR21835901_1.fastq

Sample5_SRR21835900_1.fastq

Sample6_SRR21835899_1.fastq



Alignments and coverage files in BAM and BW formats:

Each sample has a corresponding BAM and BW file names similarly as above : Sample#_SRR#

## Statistic alignment report of BAM files

Below is the alignment reports of the BAM files of each Sample:

Sample 1

    300282 + 0 in total (QC-passed reads + QC-failed reads)
    300000 + 0 primary
    0 + 0 secondary
    282 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    299972 + 0 mapped (99.90% : N/A)
    299690 + 0 primary mapped (99.90% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298380 + 0 properly paired (99.46% : N/A)
    299576 + 0 with itself and mate mapped
    114 + 0 singletons (0.04% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

Sample 2

    300000 + 0 primary
    0 + 0 secondary
    163 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    299582 + 0 mapped (99.81% : N/A)
    299419 + 0 primary mapped (99.81% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298510 + 0 properly paired (99.50% : N/A)
    299302 + 0 with itself and mate mapped
    117 + 0 singletons (0.04% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

Sample 3

    300310 + 0 in total (QC-passed reads + QC-failed reads)
    300000 + 0 primary
    0 + 0 secondary
    310 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    300015 + 0 mapped (99.90% : N/A)
    299705 + 0 primary mapped (99.90% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298708 + 0 properly paired (99.57% : N/A)
    299588 + 0 with itself and mate mapped
    117 + 0 singletons (0.04% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

Sample 4

    300000 + 0 primary
    0 + 0 secondary
    87 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    299376 + 0 mapped (99.76% : N/A)
    299289 + 0 primary mapped (99.76% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298344 + 0 properly paired (99.45% : N/A)
    299174 + 0 with itself and mate mapped
    115 + 0 singletons (0.04% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

Sample 5

    300000 + 0 primary
    0 + 0 secondary
    347 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    299995 + 0 mapped (99.88% : N/A)
    299648 + 0 primary mapped (99.88% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298264 + 0 properly paired (99.42% : N/A)
    299544 + 0 with itself and mate mapped
    104 + 0 singletons (0.03% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

Sample 6

    300000 + 0 primary
    0 + 0 secondary
    110 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    299585 + 0 mapped (99.83% : N/A)
    299475 + 0 primary mapped (99.83% : N/A)
    300000 + 0 paired in sequencing
    150000 + 0 read1
    150000 + 0 read2
    298036 + 0 properly paired (99.35% : N/A)
    299370 + 0 with itself and mate mapped
    105 + 0 singletons (0.03% : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

In summary, every sample aligns to the genome at a percentage highter than 99.7%, indicating high quality alignments. These alignment stats were generated using samtools flagstat on each of the BAM files. Different bioprojects or SRR samples can be run on this makefile using a updated design.csv file that contains information for sample, SRR, and group.
