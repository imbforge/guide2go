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
                -s ${params.WINDOW_SIZE - params.TARGET_SIZE - 2} \\
                -w ${params.WINDOW_SIZE - 1} \\
                > windows.bed 
        """
}
