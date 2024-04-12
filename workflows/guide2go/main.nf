include { BEDTOOLS_MAKEWINDOWS } from '../../modules/bedtools'
include { CHOPCHOP } from '../../modules/chopchop'

workflow GUIDE2GO {

    Channel.of( [chrom: params.CHROM, start: params.START, end: params.END] )
    | 
    collectFile { coords -> [ "coordinates.bed", coords*.value.join('\t') ] }
    |
    BEDTOOLS_MAKEWINDOWS
    |
    splitCsv(sep: '\t', header: ['chrom','start','end'])
    |
    CHOPCHOP

}