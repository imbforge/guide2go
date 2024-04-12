process CHOPCHOP {
    tag "${coords}"

    input:
        val(coords)

    output:
        path("results/results.bed"), emit: bed

    script:
        """
        chopchop.py \\
            -Target ${coords.chrom}:${coords.start}-${coords.end} \\
            -J \\
            -G hg38 \\
            -BED \\
            -o results \\
            -BB AGGCTAGTCCGT \\
            -M NGG \\
            -scoringMethod DOENCH_2016 \\
            -R 4 \\
            -g 20 \\
            -rm1perfOff
        """
}
