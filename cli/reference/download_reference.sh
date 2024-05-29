#!/bin/bash

# config variable
source ./shellsrc/utils/yaml_helper.sh

# local variable
URL=https://ftp.ensemblgenomes.ebi.ac.uk/pub/plants/release-58

# argments
command=$1

mkdir -p ${utils_data_dir}${species_reference_genome}/reference

# used by gene expression level analysis
if [ "${command}" = "gene_expression" ]; then
    echo ${command}
    # install dna file
    curl \
        -o ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.dna.toplevel.fa.gz \
        ${URL}/fasta/oryza_sativa/dna/${species_name}.${species_reference_genome}.dna.toplevel.fa.gz
    # unpigz \
    #     ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.dna.toplevel.fa.gz \
    #     ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.dna.toplevel.fa
    # install gff3 file
    curl \
        -o ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.58.gff3.gz \
        ${URL}/gff3/oryza_sativa/${species_name}.${species_reference_genome}.58.gff3.gz
    unpigz \
        ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.58.gff3.gz \
        ${utils_data_dir}${species_reference_genome}/reference/${species_name}.${species_reference_genome}.58.gff3
else
    echo "undefined command"
fi