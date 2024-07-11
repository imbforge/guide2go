process CHOPCHOP {
    tag "${coords}"

    input:
        val(coords)

    output:
        path("results.tsv"), emit: tsv
        path("**/results.bed"), emit: bed

    script:
        def region = "${coords.chrom}:${coords.start}-${coords.end}"
        """
        chopchop.py \\
            -T 1 \\
            -J \\
            -G ${params.ORGANISM} \\
            -BED \\
            -GenBank \\
            -Target ${region} \\
            -filterGCmin 10 \\
            -filterGCmax 90 \\
            -g ${params.TARGET_SIZE} \\
            -f NN \\
            -n N \\
            -R 4 \\
            -v 3 \\
            -BB AGGCTAGTCCGT \\
            -M NGG \\
            -scoringMethod ${params.SCORING_METHOD} \\
            -R 4 \\
            -g 20 \\
            -o ${region} | cut -f 2- > results.tsv
        """
}
