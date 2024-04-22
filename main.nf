#!/usr/bin/env nextflow

include { validateParameters; paramsHelp; paramsSummaryLog } from 'plugin/nf-validation'
include { GUIDE2GO } from './workflows/guide2go'

if (params.help) {
   log.info paramsHelp("nextflow run imbforge/guide2go --CHROM chr1 --START 101260000 --END 101265000")
   exit 0
}

validateParameters()

log.info paramsSummaryLog(workflow)

workflow {
    
    GUIDE2GO()

}
