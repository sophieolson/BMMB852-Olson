## Week 10 assignment- adding variant calling to makefile

The goal of the Week 10 assignment is to add variant calling to our code by using our BAM files to make vcf files that contain information about variants throughout one or more SRR sample compared to the reference genome. These vcf files can then be visualized in IGV to identify variants.

## Operating the makefile



The make file first includes commands to download the Staphlyococcus aureus reference genome where the BAM files will align to. Because the bam alignments rely on the refrence genome, the genome has to be acquired before the next steps. Therefore run:

    make genome ACC=NC_007793.1
    make index
    make faidx

Other actions within the make file include: fastq align bigwig stats vcf

each can be run indiviually, but they are also all listed under the action all, so as described in th enext section, all actions will be set to run at the same time. 

fastq downloads the SRR sequencing data into fastq files.

align takes the fastq files adn aligns them to the reference genome.

bigwig creates bw files to better visualize the coverage of sequencing in IGV

stats gives information such as how well the sequencing files aligned to the reference genome and how much coverage they have. 

# Variant calling for a single SRR

The SRR I chose to use from the six papers is SRR=SRR21835896, labeled as sample 3 in my design.csv

To download, align, and call variants for this single SRR use:

    make all SRR=SRR21835896

This results in BAM, bw, and vcf files, all which can be visualized in IGV.

Here is a screen shot of the BAM and vcf files of SRR=SRR21835896, and you can see that the vcf file marks the location of variants from the sample that do not match the reference genome.

<img width="1398" height="838" alt="Screenshot 2025-11-02 193207" src="https://github.com/user-attachments/assets/144c30c2-75cd-4211-92e2-56b70710d642" />





# Variant calling multiple SRRs

To create vcf files of multiple SRR samples at once, a design file is utilized. The file contains all six samples from the staphylococcus paper, the first three being controls and the last three being the experimental samples, and are labeled as such:

Sample1_SRR21835898_1

Sample2_SRR21835897_1

Sample3_SRR21835896_1

Sample4_SRR21835901_1

Sample5_SRR21835900_1

Sample6_SRR21835899_1

To pull the SRR numbers from the design.csv and run the all command in the make file to create the vcfs use this code

     cat design.csv |     parallel --colsep , --header : --eta --lb -j 2         make SRR={SRR} SAMPLE={SAMPLE} GROUP={GROUP} all

Below is a igv window showing all 6 vcf files, all of which contain different variants, including the blanks, highlighting the importance of knowing exactly how your sample differs from the reference genome.


<img width="1390" height="889" alt="Screenshot 2025-11-02 200006" src="https://github.com/user-attachments/assets/0f061ef6-b908-4499-b6e2-17021ffdcb42" />


# Multisample vcf

A multisample vcf combines all the individual vcf files from different samples into a single file. This relies on all vcf files having already been made, so it can not be run in parellel with other functions incase not all vcf files are made before it starts. Therefore, after entering the command listed in the section above, use this code to create the multisample vcf

    make merge

The merged files can then be opened through the single vcf file on IGV to see each sample variants individually in their own line, as well as a line that includes the variants from all 6 samples. 


<img width="1392" height="519" alt="Screenshot 2025-11-02 212936" src="https://github.com/user-attachments/assets/a4c3b08c-6993-4feb-a2a0-37d52a64f66e" />
