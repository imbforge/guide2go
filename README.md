# guide2go

## Description

This is a small nextflow pipeline to find CRISPR targets in larger genomic regions.
It uses the [cli version](https://bitbucket.org/valenlab/chopchop) of [chopchop](http://chopchop.cbu.uib.no/) and generates 40kb sliding windows for parallel processing.
At the end, potential targets across all windows are merged and can (optionally) be filtered for the presence of allelic SNPs within their respective PAM sequence.

## Usage

```bash
nextflow imbforge/guide2go --CHROM <chromosome_identifier> --START <start_coordinate> --END <end_coordinate> --ORGANISM <hg38|mm10> --ALLELES <path/to/vcf|path/to/bed>
```

## Overview

```mermaid
flowchart TB
    v1([nextflow run imbforge/guide2go])
    subgraph " "
        v3(( ))
        v2(((MAKEWINDOWS
        40kb sliding)))
        v4(((CHOPCHOP)))
        subgraph " "
            v9(((INTERSECT)))
            v11("variants.bed")
        end
        v6(( ))
        v8("results.bed")
    end
    v7("results.tsv")
    v10("results.filtered.tsv")
    v12("results.filtered.bed")
    v1 -->|chr:start-end| v3
    v3 --> v2
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v2 --- v4
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v4 --- v6
    v6 --> v7
    v6 --> v8
    v8 --> v9
    v11 --> v9
    v9 --> v10
    v9 --> v12
```