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
    # install cdna file (for kalisto tool)
    curl -o ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz \
        ${URL}fasta/oryza_sativa/cdna/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz

    # unzip
    gunzip ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa.gz
else
    echo "undefined command"
fi