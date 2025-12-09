## Week 13- Generating a genome-based RNA-seq count matrix

The goal of this assignemtn is to take samples from the staphylococcus paper and generate a count matrix to be able to look for differentially expressed genes between two different groups, control and sodium propionate added cells. 

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

## Obtaining GTF file

A GTF file is required rather than a GFF file for featureCounts to create a count matrix. No gtf was provided for the ACC=NC_007793.1 staphylococcus genome so it could not be downloaded directly. gffread is a common tool to convert GFF files to GTF, but after much trial and error, this tool would not work for me. Instead, I had to use:

     python3 << 'EOF'
    import re

    gff = "refs/Staphylococcus_aureus.gff"
    gtf = "refs/Staphylococcus_aureus.gtf"

    def parse_attrs(s):
        attrs = {}
        for part in s.strip().split(';'):
            if '=' in part:
                k, v = part.split('=', 1)
                attrs[k] = v
        return attrs

    records = []

    with open(gff) as fh:
        for line in fh:
            if line.startswith('#') or not line.strip():
                continue
            cols = line.strip().split('\t')
            if len(cols) < 9:
                continue
            attrs = parse_attrs(cols[8])
            gene_id = attrs.get("locus_tag") or attrs.get("gene") or attrs.get("Name") or attrs.get("ID") or "unknown"
            transcript_id = attrs.get("Parent", gene_id)
    EOF out.write("\n".join(records))cols))ranscript_id "{transcript_id}";'

## Running feature counter and creating count matrix

To run feature counter use:

    make counts

To compile the matrices together into a single file use:

    make matrix

The final count matrix includes all samples and the read counts of each sample for each gene


<img width="1124" height="550" alt="Screenshot 2025-12-07 225848" src="https://github.com/user-attachments/assets/5a8a966f-a133-464e-8a41-7ab63a06cbfa" />



In looking at a few lines of this matrix, we can see multiple genes that seem to be expressed the same between groups, and some that appear to be differentially expressed. In each case, there is a general similarity between samples within the same group, as in there are not large differences in gene expression between control samples. This is what si expected because each sample in this group are very similar, and their gene expression should also be very similar and will be captured as such in the RNA-seq data. The second and third row in the matrix corresponding to SAUSA300_RS00015 and SAUSA300_RS00020 show very similar gene counts between the control and test group, indicating that the addition of sodium propionate do not alter the expression of these genes. WP_000864305 appears to have a large increase in the sodium propionate samplescompared to the control, indicating that sodium propionate is causing an increase of the expression of these genes.

## Viewing Data in IGV

<img width="1517" height="1037" alt="Screenshot 2025-12-07 230905" src="https://github.com/user-attachments/assets/4871a5a4-2aff-4866-86e3-c943c1487e4f" />


In this picutre we see samples of control and sodium propionate with their reads colored by read strnd and in the collapsed view so that we can see trends in the amount of reads in each sample. This RNA-seq data is from a bi directional method as we can see that reads are both in the sense and antisense direction. We can also see that reads are aligning with the presence of a gene indicating that RNA-seq is being used as it can only capture reads for RNA that is being made rather than for the entire genome.
