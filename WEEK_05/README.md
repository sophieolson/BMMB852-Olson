 # Week 5 Homework

 I am working on the Methicillin-resistant Stayphlococcus aureus paper, this week 5 assignment is partially based off work done last week. My first bash file named Week_5_script.sh shows the bash shell for downloading genomic data for the organism of interest of the paper. My second bash file, seqdataset.sh shows how to download sequencing data from the paper. ontseq.sh is the thrid and final bash file, listing the commands needed to look at the quality of a different data set from the same organism.

 ## Group 3: Staphylococcus paper genome

 genome accession number = GCF_000013465.1

 see bash shell for downloading the and visualizing the genome

## Downloading sequencing data sets

Bioproject ID = PRJNA887926
SRA = SRR21835896

See seqdataset.sh for commands

 ## Estimating data needed for 10x coverage

The genome is 2,872,769 nt long.

The data set has 3182.4 million sequenced bases

Coverage= sum of sequenced bases / length of genome

Plugging those numbers in for L and G, the current coverage is 1107.8. Therefore to get 10x coverage need 10/1107.8= 1/110.78 sequenced bases.

1.7 million reads / 110.78 = 15454 reads

28.7 million bases and 15454 reads are how many I need in my downloaded data to get 10x genome coverage

## Basic stats on dowloaded reads

The sum length of the data is 1591208742, and the number of sequences is 15754542. The number of bases sequnced in my 10x coverage data is 28.7 million bases.

## FASTQC quality report

<img width="1109" height="805" alt="Screenshot 2025-09-26 164303" src="https://github.com/user-attachments/assets/58dccd77-deb8-4e3f-bdd0-018110af482c" />


Above is a photo of the per base sequnce quality of the 10x coverage data descriped in seqdataset.sh file. All bases appear to have a very high quality being at the top of the green section. The basic statistics secion summarizes that there are 15754542reads and 1.5gbp used for this measurment. There are no sequences flagged for poor quality and three is 34% GC content among the reads. Overall the quality of these sequencing reads are very high.

## Quality control steps

Per instructions in Friday's lecture, trimming and filtering steps are not completed here as we did not cover it in class.

## Comparing sequencing platforms

The alternative Staphylococcus aureus data set I chose from the SRA was sequenced using oxford nanopore, where the sequencing from the main paper is from Illumina sequencing. 

The bioproject ID is PRJNA976947

The SRA is SRR24781619

<img width="1077" height="800" alt="Screenshot 2025-09-26 173244" src="https://github.com/user-attachments/assets/568e4336-4c63-40f2-8b2a-146ebb4e0b42" />


This data set has 1.7 million reads and 2592.0 million sequenced bases, which is only about two thirds of the amount of bases sequenced in the original data set. 

When looking at the FASTQC of the new data set, it also has zero bases that are flagged for poor quality, and the scores for the base per sequence quality are much higher with scores nearing 100, whereas the scores of the original data were all in the mid 30's. this indicated that although both datasets are good, this latter set has an even higher quality. The error bars do however dip into the yellow section for this data indicating that there is a range in quality within the set. It also has a higher GC content of 54%.
