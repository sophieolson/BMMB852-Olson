## Week 11 assignment- Establishing the effects of variants

The goal of the Week 11 assignment is to look at variants within the merged vcf files to identify variants of different types such as missense nonsense, frameshift, and synonymous. This is crucial to understanding the whether variants are silent or are causing large impacts to the gene involved. 

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




# Multisample vcf

A multisample vcf combines all the individual vcf files from different samples into a single file. This relies on all vcf files having already been made, so it can not be run in parellel with other functions incase not all vcf files are made before it starts. Therefore, after entering the command listed in the section above, use this code to create the multisample vcf

    make merge

The merged files can then be opened through the single vcf file on IGV to see each sample variants individually in their own line, as well as a line that includes the variants from all 6 samples. 


# Attempting to use EnsembleVEP

My original plan was to use the web interface of Ensemble to look at my variants. Because I am using the Staphylococcus aureus paper, I needed to use bacteria ensemble rather than ensemble. BacteriaEnsemble can be found here: https://bacteria.ensembl.org/Staphylococcus_aureus_gca_002934945/Tools/VEP/Results?tl=5n0NLCRHNHIbjTJI-24815409

The strain the paper and i have used is Staphylococcus aureus N315, which is the strain I selected in the interface. 

I then uploaded my merged vcf file, which was created in last week's assignment. 

Below is a screenshot of my results, where is appears that no variants are being processed. I am unsure of why this is the case, there could be something wrong with my merged vcf, or perhaps the strain I am choosing is not actually the same as the one in the paper. Due to this roadblock, all variants will instead be identified by eye.

<img width="1410" height="644" alt="Screenshot 2025-11-06 125456" src="https://github.com/user-attachments/assets/9caa7c4e-14f7-419f-aa9e-a84d96cedf49" />


# Visual Inspection via IGV for 3 examples

Variant 1

The first variant is within the coding region of a gene named gene-SAUSA300_RS07940. The variant is an A to G mutation at the third position of the codon, also known as the wobble position. The original codon: CTA encodes for Leucine, and the variant codon CTG also encodes for leucine. This is an example of the most commonly found variant, the silent mutation, where despite a mutation in the base, the same amino acid will be encoded for. 



<img width="1370" height="865" alt="Screenshot 2025-11-06 125713" src="https://github.com/user-attachments/assets/3526ecfd-ae84-487b-a351-d54bd7b7fbe4" />

Variant 2

The second variant is within the coding region of a gene called gene-SAUSA300_RS11040. The variant is a T to C mutation at the second position of a codon triplet. The original codon of ATG encodes for methionine, and even though methionine is the start codon, because it is in the middle of a gene already being encoded, it only acts as a regular methionine residue. The variant codon: ACG encodes for threonine, an entirely different amino acid. This variant then leads to a missense mutation. Altering even one amino acid can alter potientially alter the folding, stability, or function of the protein.



<img width="1375" height="783" alt="Screenshot 2025-11-06 130303" src="https://github.com/user-attachments/assets/dd0ae241-51fc-4408-a65c-7365fb86256d" />


Variant 3


The Third variant is within the coding region of a gene identified as gene-SAUSA300_RS10410. This variant is an example of a first position variant, with a G to A variation. The original codon: GGC encodes for Glycine, and the variant: AGC encodes for serine. This is an example of a missense mutation. While there is a chance that a second postion variant can still lead to the coding of the same amino acid, first position vairants almost always lead to a missense mutation. 

<img width="1347" height="614" alt="Screenshot 2025-11-06 132600" src="https://github.com/user-attachments/assets/bd382c18-6081-4cc8-b4eb-b8d5ef9a0401" />




Other mutations are also possible with single nucleotide variations. These include nonsense mutations which add a premature stop codon to the coding region, and frameshift mutations which cause the reading frame to shift and therefore all subsequent amino acids to change due to an insertion or a deletion. 
