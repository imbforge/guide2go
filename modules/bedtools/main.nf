process BEDTOOLS_MAKEWINDOWS {
    tag "${params.CHROM}:${params.START}-${params.END}"
  
    input:
        path(coords)

    output:
        path("windows.bed"), emit: bed

    script:
        """
        bedtools \\
            makewindows \\
                -b ${coords} \\
                -s ${params.WINDOW_SIZE - params.TARGET_SIZE - 3} \\
                -w ${params.WINDOW_SIZE - 1} \\
                > windows.bed 
        """
}

process BEDTOOLS_INTERSECT {
    tag "${snps}"

    when:
        variants

    input:
        path(tsv)
        path(bed)
        path(variants)

    output:
        path("results_filtered.tsv"), emit: tsv

    script:
        """
        awk '{ FS=OFS="\\t"; if(\$6 == "+") {print \$1,\$3-2,\$3,\$6,\$2,\$3} else {print \$1,\$2,\$2+2,\$6,\$2,\$3} }' ${bed} > pam.bed

        bedtools \\
            intersect \\
                -a pam.bed \\
                -b ${variants} \\
                > targets_filtered.bed

        grep -f <(awk '{FS=OFS="\\t"; print \$5+1}' targets_filtered.bed) ${tsv} > results_filtered.tsv
        """
}
