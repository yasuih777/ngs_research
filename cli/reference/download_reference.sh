#!/bin/bash

# config variable
source ./shellsrc/io/yaml_helper.sh

# local variable
URL=https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-58/

# argments
command=$1

mkdir -p ${utils_data_dir}${species_reference_genome}/reference

# used by gene expression level analysis
if [ "${command}" = "gene_expression" ]; then
    echo ${command}
    # install cdna file (for kalisto tool)
    curl \
        -o ${utils_data_dir}${species_reference_genome}/reference/${species_name}.IRGSP-1.0.cdna.all.fa.gz \
        ${URL}fasta/oryza_sativa/cdna/${species_name}.IRGSP-1.0.cdna.all.fa.gz
else
    echo "undefined command"
fi