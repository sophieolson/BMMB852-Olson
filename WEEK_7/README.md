# Week 7 Assignment

This week's assignment is based off of the Makefile made in Week 6, and includes the addition of creating bigwig file coverage tracks for both the original data and the second sequencing data obtained with a different sequencing method.

The reference gene of staphylococcus areus has the accession number ACC=NC_007793.1 and can be downloaded using:

```
make genome ACC=NC_007793.1
```

The sequencing data is found under the SRR SRR=SRR21835896 to have 10x coverage 150000 reads were chosen and can be downloaded using:

```
make fastq SRR=SRR21835896 N=150000
```

The reference genome is indexed using:

```
make index
```

The sequencing data was then aligned to the reference genome using:

```
make align SRR=SRR21835896
```

To look at alignment statistics of the data to the refence the floowing can be used:

```
make stats SRR=SRR21835896
```

## making bigwig files

in order to better visualize the data on IGV, we can convert BAM files to bigwig files using

```
make bigwig SRR=SRR21835896
```

## Downloading second sequencing data

To download the second sequencing dataset that was collected using a different sequencing method, and to align the data to the staphylococcus aureus genome, as well as to create a bigwig file, the following can be used

```
make fastq align bigwig stats SRR=SRR24781619
```

## Briefly describe the differences between the alignment in both files

Comparing BAM to big wig files, bam files allow you to see specific reads as well as the general coverage bar, but requires you to be zoomed in to see either. Bigwig files only show the general coverage but it shows it no matter what zoom you are at. The sequencing data from the paper, labeled as SRR=SRR21835896 has a much more reads and a better genome wide coverage than the second data set labeled as SRR=SRR24781619. Shown below is an example of how different the read coverage is between the two sequencing data sets. 

<img width="1405" height="994" alt="Screenshot 2025-10-12 214147" src="https://github.com/user-attachments/assets/8444decf-6ca0-4d68-b15c-a831b5c686ec" />

## Briefly compare the statistics for the two BAM files

Using samtools flagstat in:


```
make stats SRR=SRR21835896
```

this is the data for the orignal dataset 

<pre> samtools flagstat bam/SRR21835896.bam
300163 + 0 in total (QC-passed reads + QC-failed reads)
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
samtools coverage bam/SRR21835896.bam
#rname  startpos        endpos  numreads        covbases        coverage        meandepth       meanbaseq    meanmapq
NC_007793.1     1       2872769 299582  1314887 45.7707 10.5004 36.2    59.9 </pre>


```
make stats SRR=SRR24781619
```
this is the data for the second bam file

<pre> samtools flagstat bam/SRR24781619.bam
150780 + 0 in total (QC-passed reads + QC-failed reads)
150000 + 0 primary
0 + 0 secondary
780 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
1728 + 0 mapped (1.15% : N/A)
948 + 0 primary mapped (0.63% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
samtools coverage bam/SRR24781619.bam
#rname  startpos        endpos  numreads        covbases        coverage        meandepth       meanbaseq    meanmapq
NC_007793.1     1       2872769 1728    194603  6.77406 0.16216 34.5    3.41 </pre>

In summary, the dataset from the original paper has a paired end read type, while the seperate data set used oxford nanopore sequencing which is single ended. For this reason, when both use N=150000, the orginal data will have twice the number of reads. The original data maps to the genome very well with 98.7% coverage, while the second data maps very poorly, with only 1.15% of the reads mapping to the genome. The read coverage of the original data is 10.5x, while the read coverage of the second dataset is 6.77x.


## How many primary alignments does each of your BAM files contain?

Also shown in the samtools flagstat information listed above, the original sequencing data set contains 300000 primary alignments, while the second data set contains 150000. This is because I set N=150000 for each, but the orignal sequencing method was paired end while the second one is only single sided, meaning the primary reads will be half, as we see.

## What coordinate has the largest observed coverage?

This was determined using samtools depth in the stats section of my make file as shown:

```
make stats SRR=SRR21835896
```


the result for the original data is:

<pre> samtools depth bam/SRR21835896.bam | sort -k3,3nr | head -1
NC_007793.1     2500332 29588 </pre>

this means that the coordinate 2500322 has the largest observed coverage with 29588 reads.

For the second data set:

```
make stats SRR=SRR24781619
```

<pre> samtools depth bam/SRR24781619.bam | sort -k3,3nr | head -1
NC_007793.1     513833  72 </pre>

This says that the second data set has its highest read coverage at coordinate 513833 with 72 reads.


## Select a gene of interest. How many alignments on the forward strand cover the gene?

My gene of interest is MecA, which is responsible for methylin resistance, causing many infections in hospitals.


To answer this question, I used samtools view, which allows you to count the forward reads at a specific section. The location of the gene is between 1526530-1541662.


```
make stats SRR=SRR21835896
```

<pre> samtools view -c -F 0x10 bam/SRR21835896.bam NC_007793.1:1526530-1541662
1535 </pre>

```
make stats SRR=SRR24781619
```

<pre> samtools view -c -F 0x10 bam/SRR24781619.bam NC_007793.1:1526530-1541662
1 </pre>

The original data has 1535 forwards reads in this gene, while the second data set only has one read here.
<img width="1395" height="920" alt="Screenshot 2025-10-12 223425" src="https://github.com/user-attachments/assets/54c4947c-871c-4b4f-9729-af58b263958c" />



