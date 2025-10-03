# Week 6 assignment- Short Read alignments

This homework is based on the Staphylococcus aureus paper. The other file in this folder is a Makefile which contains all code used in this assignemnt.

The make file includes code for obtaining the stapyhlococcus genome as well as downloading sequencing reads from SRA.

## Obtaining the genome

The target genome: contains code needed to downlaod the reference genome using the accession number ACC=NC_007793.1. using seqkit to look at the stats of the genome, this is the out put 

<pre> mkdir -p refs/
bio fetch NC_007793.1 --format fasta > refs/Staphylococcus_aureus.fa
seqkit stats refs/Staphylococcus_aureus.fa
file                           format  type  num_seqs    sum_len    min_len    avg_len    max_len
refs/Staphylococcus_aureus.fa  FASTA   DNA          1  2,872,769  2,872,769  2,872,769  2,872,769 </pre>


## Obtaining sequence data

Sequences from the paper were obtained using SRR=SRR21835896 and the code listed under fastq:

These are the statistics of the downloaded sequencing data.

<pre>mkdir -p reads/
fastq-dump -X 150000 --outdir reads --split-files SRR21835896
Read 150000 spots for SRR21835896
Written 150000 spots for SRR21835896
seqkit stats reads/SRR21835896_1.fastq reads/SRR21835896_2.fastq
processed files:  2 / 2 [======================================] ETA: 0s. done
file                       format  type  num_seqs     sum_len  min_len  avg_len  max_len
reads/SRR21835896_1.fastq  FASTQ   DNA    150,000  15,150,000      101      101      101
reads/SRR21835896_2.fastq  FASTQ   DNA    150,000  15,150,000      101      101      101</pre>

## Indexing the genome

Target index: contains code to index the genome using bwa.


## Generating BAM file

Target align: contains code to align the reads to the genome and convert them into a BAM file.

## Visualizing BAM files

To then open the genome and BAM files in IGV I clicked on genomes then load genomes from file, in the refs directory made, I clicked on the fasta file. To open the BAM files I clicking on file, load from file, then navigated to the BAM folder which contained a BAM and bambia file, both of which I opened. This is the resulting screen after zooming in: 

<img width="1375" height="771" alt="Screenshot 2025-10-02 211430" src="https://github.com/user-attachments/assets/0a0ba14c-f511-4150-8166-4e823e33abd8" />


## Generating alignment statistics

Target stats: lists the code needed to view the alignment statistics of the BAM file just made.

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
0 + 0 with mate mapped to a different chr (mapQ>=5) </pre>

What percentage of reads aligned to the genome?

99.81% of reads aligned to the genome, which is shown in the primary mapped line.

What was the expected average coverage?

10x coverage is expected.

I used 150000 reads in the data because that equals 10x coverage of the genome since there are 2,872769bp in the genome and the average read length is 101bp, so 

Number of reads = (10 × 2,872,769) / 101 ≈ 284,930,

 but the reads are paired end needs so I only need half, which rounding up is equal to 150000 reads.

What is the observed average coverage?

 The observed average coverage is 10.5x, which makes sense because I rounded up in how many reads I used so it should be more than 10x slightly. 

<pre> samtools coverage bam/SRR21835896.bam
#rname  startpos        endpos  numreads        covbases        coverage        meandepth       meanbaseq    meanmapq
NC_007793.1     1       2872769 299582  1314887 45.7707 10.5004 36.2    59.9 </pre>

How much does the coverage vary across the genome? (Provide a visual estimate.)

The coverage does vary very widely throughout the genome, I see many locations that have about 5 reads in the same location as being the most common. Yet, many places have less than 5 reads or even no reads for long stretchs which can be seen in the first picture, while other regions will have well over 100x coverage as pictured in the second image. Even though the variation is very large, this is expected because some regions of the genome are much more accessable and will therefore be easier to sequence.

<img width="1406" height="759" alt="Screenshot 2025-10-02 214749" src="https://github.com/user-attachments/assets/b6e6cefd-3b4c-4e3c-84be-45d1485c7798" />


<img width="1393" height="861" alt="Screenshot 2025-10-02 214847" src="https://github.com/user-attachments/assets/9f3e3a25-c63c-45a9-a9bc-d25df6656932" />
