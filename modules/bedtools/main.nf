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
    tag "${variants}"

    when:
        variants

    input:
        path(tsv)
        path(bed)
        path(variants)

    output:
        path("results.filtered.tsv"), emit: tsv
        path("results.filtered.bed"), emit: bed

    script:
        """
        awk '{ FS=OFS="\\t"; if(\$6 == "+") {print \$1,\$3-2,\$3,\$6,\$2,\$3} else {print \$1,\$2,\$2+2,\$6,\$2,\$3} }' ${bed} | sort -k1,1 -k2,2n > pam_coords.bed

        bedtools \\
            intersect \\
                -wa \\
                -wb \\
                -a pam_coords.bed \\
                -b ${variants} \\
                > results.filtered.bed

        grep -f <(awk '{FS=OFS="\\t"; print \$5+1}' results.filtered.bed) ${tsv} > results.filtered.tsv || true
        """
}
