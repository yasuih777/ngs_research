#!/bin/bash

# config variable
source ./shellsrc/utils/yaml_helper.sh

# quant gene expression useing kalisto tool
mkdir -p ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/quant
cat ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/SRR_Acc_List.txt | while read sample; do echo processing ${sample}; \        
    kallisto quant \
        --index ${utils_data_dir}${species_reference_genome}/reference/kallisto_index/kallisto.idx \
        --output-dir ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/quant/${sample} \
        --bootstrap-samples 100 \
        --threads ${utils_threads} \
        ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_1.fastq.gz \
        ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_2.fastq.gz \
    ; done; echo finished!