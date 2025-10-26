## Week 9 assignment- revising Week 8 homework based on given feedback

The goal of the Week 8 assignment is to create a design.csv file that contains information for each SRR sample in the paper the previous assignmetns have been based off of. This design file can then be used with the Makefile to download, align, and assess the sample quality and coverage to the reference genome. 

The goal of this week's assignemnt is to take the feedback we were given and make the necessary changes to the Week 8 Makefile to resolve any issues. 

## Operating the makefile


For a more detailed explination, look at the Week 8 Readme.md


The make file first includes commands to download the Staphlyococcus aureus reference genome where the BAM files will align to. Because the bam alignments rely on the refrence genome, the genome has to be acquired before the next steps. Therefore run:

    make genome ACC=NC_007793.1
    make index
    make faidx

Now the samples listed in the design.csv can be run using the all comand of the makefile, which exculdes steps for downloading the genome. 

     cat design.csv |     parallel --colsep , --header : --eta --lb -j 2         make SRR={SRR} SAMPLE={SAMPLE} GROUP={GROUP} all

# feedback given 

The two corrections I need to make are:

Add -n to the unzip so that the README.md is not overwritten


Code needs to create a bigwig coverage files as well


# Not overwritting the README.md

If a README.md file already exists in a directory and you try to add a new one, the original will be replaced by the new file. Instead what I want is to create a seperate readme, but still have both of them present. The -n command prevents the original README.md from being overwritten, so both are avalible. To correct this, I added a -n to the genome section of the makefile in the unzip command so that the ncbi_dataset makefile does not overwrite the orginal makefile. 

    unzip -n ncbi_dataset.zip


# bigwig coverage files

bigwig files store data about the coverage of a BAM file to a reference genome. Because there are six samples in the reference dataset, I will have 6 bigwig files, all ending in .bw. Within my directory there is a folder entitiled bigwig, which contains two folders: control and SodiumPropionate. The control folder holds the bigwig coverage files for samples 1 through 3 and the SodiumPropionate folder contains the coverage files for samples 4 through 6. These coverage files can then be viewed using IGV, where the coverage of each samples sequencing run shows which areas of the genome were sequenced and to what level of coverage. Below is a IGV screen showing the bigwig files for all 6 samples. When I ran my commands the bigwig files were present without and changes needed. Perhaps solving the first issue fixed this one as well. 
<img width="1403" height="539" alt="Screenshot 2025-10-26 122850" src="https://github.com/user-attachments/assets/d9694a58-8dd3-4f28-a694-c0085cea5e57" />

