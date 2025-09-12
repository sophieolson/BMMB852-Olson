 # Week 3 Homework

 ## Using IGV to visualize genomes and associated annotations

I chose to visualize the NF135.c10 strain of Plasmodium falciparum, using the data base plasmoDB

     wget https://plasmodb.org/common/downloads/release-68/PfalciparumNF135C10/fasta/data/PlasmoDB-68_PfalciparumNF135C10_Genome.fasta


 ## How big is the genome?

 The genome contains 23 sequences and has a sumlength of 23,508,985 nucleotides. 

     seqkit stats PlasmoDB-68_PfalciparumNF135C10_Genome.fasta

The gff file has ten feature types, which are: CDS, exon, mRNA, ncRNA_gene, protein_coding_gene, pseudogene, pseudogenic_transcript, rRNA, snRNA, and tRNA

     wget https://plasmodb.org/common/downloads/release-68/PfalciparumNF135C10/gff/data/PlasmoDB-68_PfalciparumNF135C10.gff

     awk '{print $3}' PlasmoDB-68_PfalciparumNF135C10.gff | sort | uniq

 ## Seperating intervals into different files

I seperated the interval of type "gene" into a seperate file called genes.gff

 

     awk '$3 ~ /gene/' PlasmoDB-68_PfalciparumNF135C10.gff > genes.gff


 ## Comparing Original GFF with simplified GFF

In comparing the simplified file to the original, the simplified does not contain information about UTRs or about exons and CDS when you click on the gene for more information. Listed below is an image of the original gff on top versus the simplified gff below, where you can see less information is given on what makes up the genes that are shown.
<img width="1400" height="384" alt="Screenshot 2025-09-12 165545" src="https://github.com/user-attachments/assets/d8b6a973-d151-48f0-a645-1333a4a15eda" />


 ## Visualization of the translation table

 After zooming in to view the translation table and switching between sequence directions, it is very clear as to which way the gene I zoomed in on goes because the opposite direction leads to many premature stop codons, making the gene nonfunctional. The correct translation is the bottom translation.

 Correct direction:
<img width="1398" height="428" alt="Screenshot 2025-09-12 171143" src="https://github.com/user-attachments/assets/7e35e2e9-de7a-4ae5-a508-ca3e52eaf54a" />


 Incorrect direction:<img width="1401" height="401" alt="Screenshot 2025-09-12 171157" src="https://github.com/user-attachments/assets/1c221f89-88ef-417d-9154-94fad0c139ad" />


 ## Start and stop codons

 The gene PfNF135_070011900 has a start codon and a stop codon at the correct positions, as shown in the third row of the translation reading frames.

 Start codon:
<img width="1302" height="541" alt="Screenshot 2025-09-12 171251" src="https://github.com/user-attachments/assets/fc1a7e77-9639-415d-93f4-54fa925edeb5" />


 Stop codon:<img width="1402" height="505" alt="Screenshot 2025-09-12 171312" src="https://github.com/user-attachments/assets/c5b470b8-acb4-4e5f-a1eb-adb7b893fc0c" />
