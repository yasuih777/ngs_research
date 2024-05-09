#!/bin/bash

# config valiable
source ./config/shell_config.sh

# local valiable
URL=https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-58/

# argments
COMMAND=$1

mkdir -p ${DATA_DIR}${REFERENCE_GENOME}/reference

# used by gene expression level analysis
if [ "${COMMAND}" = "gene_expression" ]; then
    echo ${COMMAND}
    # install reference genome file
    # curl -o ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.58.chr.gff3.gz \
        # ${URL}gff3/oryza_sativa/${SPECIES}.IRGSP-1.0.58.chr.gff3.gz
    # install annotation file
    # curl -o ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.dna.toplevel.fa.gz \
        # ${URL}fasta/oryza_sativa/dna/${SPECIES}.IRGSP-1.0.dna.toplevel.fa.gz
    # install cdna file (for kalisto tool)
    curl -o ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz \
        ${URL}fasta/oryza_sativa/cdna/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz

    # unzip
    # gunzip ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.58.chr.gff3.gz
    # gunzip ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.dna.toplevel.fa.gz
    gunzip ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz
else
    echo "undefined command"
fi