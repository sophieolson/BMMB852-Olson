# Week 12 assignment- genome in a bottle

This weeks assignment uses data from a 2025 paper fro the cancer geonome in a bottle project. They extensively sequence tumors using many types of sequencing, allowing us to compare across different sequencing methods.

# Option 1: Evaluate alignments across sequencing platforms

I have chosen to do option 1 for the assignment, evaluating different sequencing methods. This paper uses many different long and short read sequencing methods, and I have chosen to compare PacBio Revio Whole Genome sequencing, Oxford Nanopore Ultra Long whole genome sequencing, and Dovetail LinkPrep HiC Library and Illumina NovaseqX 2x150 sequencing. I chose these because they give a good variation between sequencing length and techonolgy used to sequence, which I expect to cause variations in mapping quality and false positive SNP rates.

I have chosen to look at Chromosome 9, specifically between chr9:8,000,000-10,000,000, 2,000,000 bases gives a enough space to find interesting differences between the sequencing methods, but not so much as to overwhelm my laptop. I chose this region on chromosome 9 because it is in the telomeric region of the chromosome. Telomere regions contain many repeats, making them difficult to properly align sequences to them, which I think makes a perfect test to see how well each sequencing method can capture a canonically difficult to sequence region of the genome. 

# Downloading the genome

To begin this analysis I downloaded the GRCh38-GIABv3 reference genome that was used in the paper. This file can then be used as the reference genome in IGV to compare the sequencing methods. 

    Make genome REF_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/release/references/GRCh38/GRCh38_GIABv3_no_alt_analysis_set_maskedGRC_decoys_MAP2K3_KMT2C_KCNJ18.fasta.gz

    Make faidx

# Sequencing method 1 PacBio Revio

PacBio Revio is a long read whole genome sequencing method that has whose read length is normally between 15 to 20 KB. I chose to use 6000 reads for my 2 million bp region of interest, meaning the covereage should be around 45x. I wanted to if SNPs/insertions/deletions were uniformly caught for all of the reads in one location, I decided to use a large coverage rather than the 10x i typically use. 

    make all N=6000 SRR=SRR30646126 BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/PacBio_Revio_20240125/HG008-N-P_PacBio-HiFi-Revio_20240125_35x_GRCh38-GIABv3.bam

Below is are the alignment stats for the PacBio Revio sequencing. All reads that aligned to my region of interest were QC-passed reads, and 100% of them aligned to the reference genome. This means that there is very good mapping quality for this method. 

    4968 + 0 in total (QC-passed reads + QC-failed reads)
    4937 + 0 primary
    0 + 0 secondary
    31 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    4968 + 0 mapped (100.00% : N/A)
    4937 + 0 primary mapped (100.00% : N/A)
    0 + 0 paired in sequencing
    0 + 0 read1
    0 + 0 read2
    0 + 0 properly paired (N/A : N/A)
    0 + 0 with itself and mate mapped
    0 + 0 singletons (N/A : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

SRR30646126

# Sequencing method 2 Oxford Nanopore Ultra Long WGS

Oxford nanopore sequencing is known as a long read sequencer that can have thousands of bases per read, but ultralong nanopore sequencing increses that greatly, leading to reads that can be over one hundred thousand bp long. To maintain a 45x coverage, with the average read being 100000, I used 9000 reads

    make all N=900 SRR=SRR33291172 BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/UCSC_ONT-UL_20231207/HG008-T_CHM13v2.0_ONT-UL-R10.4.1-dorado0.4.3_sup4.2.0_5mCG_5hmCG_54x_UCSC_20231031.bam

The alignment statistics for ONT ultra long show that 865 of 900 reads were mapped, all of those passing QC. Similarly to PacBio, 100% of the reads mapped to the reference genome. This makes sense logically because the length of each read is so long that even if there were many mismatches, there is enough information of align it to the correct location.  

    865 + 0 in total (QC-passed reads + QC-failed reads)
    834 + 0 primary
    10 + 0 secondary
    21 + 0 supplementary
    0 + 0 duplicates
    0 + 0 primary duplicates
    865 + 0 mapped (100.00% : N/A)
    834 + 0 primary mapped (100.00% : N/A)
    0 + 0 paired in sequencing
    0 + 0 read1
    0 + 0 read2
    0 + 0 properly paired (N/A : N/A)
    0 + 0 with itself and mate mapped
    0 + 0 singletons (N/A : N/A)
    0 + 0 with mate mapped to a different chr
    0 + 0 with mate mapped to a different chr (mapQ>=5)

SRR33291172

# Sequencing method 3 Dovetail LinkPrep HiC library and Illumina Novaseqx 2x150

This method uses short dual read 150bp illumina sequencing, but adds Hi-C to look at the chromatin conformation within the nucleus. This is the only short read method I am testing here, and my prediction is that it will have the most difficult time having its reads mapped because this is such a highly repetative region where there might be multiple options of where it can align due to its short length. To once again aim for 45x coverage, I used 300000 reads for this 2 million bp region.

    make all N=300000 SRR=SRR33291168 BAM_URL=https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data_somatic/HG008/Liss_lab/Dovetail_LinkPrep-ILMN_HG8NP_20250625/HG008-N-P_LinkPrep_20250625_sorted_GRCh38.bam

For the Dovetail Illumina reads, 1285753 out of 300000 reads were mapped, those of which passing QC. Interestingly 99.58% of reads were mapped to the genome. While this is not 100% like the other two methods, this was still surprisingly high to me considering how short thte reads are and how this region contains many repeats. I think that this shows that the mapping quality is quite good even under harder conditions than in other sections of the chromosome. 

    1285753 + 0 in total (QC-passed reads + QC-failed reads)
    1115506 + 0 primary
    0 + 0 secondary
    170247 + 0 supplementary
    524889 + 0 duplicates
    460935 + 0 primary duplicates
    1280296 + 0 mapped (99.58% : N/A)
    1110049 + 0 primary mapped (99.51% : N/A)
    1115506 + 0 paired in sequencing
    559969 + 0 read1
    555537 + 0 read2
    0 + 0 properly paired (0.00% : N/A)
    1104592 + 0 with itself and mate mapped
    5457 + 0 singletons (0.49% : N/A)
    221491 + 0 with mate mapped to a different chr
    210866 + 0 with mate mapped to a different chr (mapQ>=5)

SRR33291168	

# Visual inspection of the reads for each method


PacBio Revio SRR30646126

Dovetail Illumina SRR33291168

ONT UL SRR33291172

In the IGV windows the bw files are ontop, and the BAM files are below showing the individual reads. The order is Pacbio revio, Dovetail Illumina, then ONT UL, from top to bottom for each section. 

<img width="1533" height="1018" alt="Screenshot 2025-11-16 155309" src="https://github.com/user-attachments/assets/e9106b5d-003f-421f-96be-f76e9fa233ca" />


In this screenshot in the bw section on top, we can see that the read coverage for both long read methods is very consistant, while the short read illumina reads show more peaks and valleys indicating a less even coverage due to their length. There is also a large unmapped portion in the ONT UL BAM, which is unexpected at 45x coverage, which indicates that ONT UL has lower coverage uniformity than PacBio Revio.


<img width="1522" height="1013" alt="Screenshot 2025-11-16 155356" src="https://github.com/user-attachments/assets/787045dd-4f34-4a04-93b9-8f08d845e6ee" />


Taking a look at deletion and insertions, for each method it appears that the characterization of a mutation is only found in a subset of their reads. The PacBio and Illumina sequencing methods appear to report these mutations at a reasonable amount, but with ONT UL, there is a very large number of these mutations reported as can be seen by the purple bars throughout. This could indicate either a poor mapping, or a high error rate during sequencing. 
