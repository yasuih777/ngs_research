#!/bin/bash

# config valiable
source ./config/shell_config.sh

echo ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa

# create index file useing star tool
mkdir -p ${DATA_DIR}${REFERENCE_GENOME}/reference/kallisto_index
kallisto index -i ${DATA_DIR}${REFERENCE_GENOME}/reference/kallisto_index/kallisto.idx \
    ${DATA_DIR}${REFERENCE_GENOME}/reference/${SPECIES}.IRGSP-1.0.cdna.all.fa