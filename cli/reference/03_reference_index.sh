#!/bin/bash

# config variable
source ./shellsrc/io/yaml_helper.sh

echo ${utils_data_dir}${species_reference_genome}/reference/${species_name}.IRGSP-1.0.cdna.all.fa

# create index file useing kalisto tool
mkdir -p ${utils_data_dir}${species_reference_genome}/reference/kallisto_index
kallisto index -i ${utils_data_dir}${species_reference_genome}/reference/kallisto_index/kallisto.idx \
    ${utils_data_dir}${species_reference_genome}/reference/${species_name}.IRGSP-1.0.cdna.all.fa