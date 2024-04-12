#!/usr/bin/env nextflow

include { GUIDE2GO } from './workflows/guide2go'

workflow {
    
    GUIDE2GO()

}
