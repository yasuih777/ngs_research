#!/bin/bash

: '
Download SRR_Acc_List.txt from https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP375151&o=acc_s%3Aa 
and move to {mount drive}/ngs_research/IRGSP-1.0/genome_expression/data,
before this script.
'

# config valiable
source ./config/shell_config.sh

# install sra files
mkdir -p ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/sra/
prefetch --output-directory ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/sra/ \
    --option-file ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/SRR_Acc_List.txt

# install fasta file
fasterq-dump ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/sra/SRR* \
    --outdir ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/ \
    --temp ${DATA_DIR}${REFERENCE_GENOME}/${GENOME_EXPRESSION}/data/ \
    --split-files \
    --progress