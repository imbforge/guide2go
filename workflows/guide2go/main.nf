include { BEDTOOLS_MAKEWINDOWS } from '../../modules/bedtools'
include { BEDTOOLS_INTERSECT   } from '../../modules/bedtools'
include { CHOPCHOP             } from '../../modules/chopchop'

workflow GUIDE2GO {

    Channel.of( [chrom: params.CHROM, start: params.START, end: params.END] )
    | 
    collectFile { coords -> [ "coordinates.bed", coords*.value.join('\t') ] }
    |
    BEDTOOLS_MAKEWINDOWS
    |
    splitCsv( sep: '\t', header: ['chrom','start','end'] )
    |
    CHOPCHOP

    BEDTOOLS_INTERSECT(
        CHOPCHOP.out.tsv.collectFile(name: "results.tsv", storeDir: "${params.OUT}/results", keepHeader: true),
        CHOPCHOP.out.bed.collectFile(name: "results.bed", storeDir: "${params.OUT}/results", skip: 2),
        params.ALLELES ? file(params.ALLELES, checkIfExists: true) : []
    )

}