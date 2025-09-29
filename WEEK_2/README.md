# Week 2 Homework

Demonstrating data analysis at UNIX command line

## Picking an organism

The organism I chose is Rhinolophus ferrumequinum, also known as the great horseshoe bat. This bat can be found throughout Europe, Asia, and Northwestern Africa. Its name is derived from the lower part of its noseleaf resembling a horseshoe. The great horseshoe bat hunts insects and has a average liefspan of 30 years.

## Sequence Regions

The file contains 38542 sequence regions. The number of chromosomes expected is much lower, so this much be a very fragmented sequence.


      wget https://ftp.ensembl.org/pub/current_gff3/rhinolophus_ferrumequinum/Rhinolophus_ferrumequinum.mRhiFer1_v1.p.115.gff3.gz
    
    gunzip Rhinolophus_ferrumequinum.mRhiFer1_v1.p.115.gff3.gz

    cat Rhinolophus_ferrumequinum.mRhiFer1_v1.p.115.gff3 | grep RXPC | wc -l


## Features

There are 22 features in this file.


    cat Rhinolophus_ferrumequinum.mRhiFer1_v1.p.115.gff3 | grep -v '#' > rhin.gff3
    
     cat rhin.gff3 | cut -f 3 | sort | uniq -c | sort -rn | wc -l

## Genes

There are 19533 genes.

    cat rhin.gff3 | cut -f 3 | sort | uniq -c | sort -rn | head

## Unusual feature type

One unusal feature type listed is pseudogenic transcripts. These are DNA segments that resemble genes but cannot encode for proteins.  

##  Top Ten most annotated feature types

The tope ten most annotated feature types are:

* exon
* CDS
* biological regions
* mRNA
* five prime UTR
* three prime UTR
* gene
* ncRNA gene
* snRNA
* pseudogenic transcripts




## annotation level of organism

This seems like a somewhat well annotated organism because there were many gff files for this organism, yet the chromosomes were very fragmented.
