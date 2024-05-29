#!/bin/bash

# config variable
source ./shellsrc/io/yaml_helper.sh
source ./shellsrc/io/pkg_helper.sh

# create index file useing kalisto tool
mkdir -p ${utils_data_dir}${species_reference_genome}/reference/hisat2_index
${rsem_prepare_reference} \
    --gff3 ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.58.gff3 \
    --hisat2-hca \
    --hisat2-path ${hisat2} \
    --num-threads ${utils_threads} \
    ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.dna.toplevel.fa \
    ${utils_data_dir}${species_reference_genome}/reference/hisat2_index/rsem_index
