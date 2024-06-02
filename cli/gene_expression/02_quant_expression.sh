#!/bin/bash

# config variable
source ./shellsrc/io/yaml_helper.sh
source ./shellsrc/io/pkg_helper.sh

# quant gene expression useing kalisto tool
mkdir -p ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/hisat2_quant
while read sample
do
mkdir -p ${sample}
${rsem_calculate_expression} \
    --hisat2-hca \
    --hisat2-path ${hisat2} \
    --num-threads ${utils_threads} \
    --paired-end \
    ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_1.fastq.gz \
    ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_2.fastq.gz \
    ${utils_data_dir}${species_reference_genome}/reference/hisat2_index/rsem_index \
    ${sample}/${sample}
mv -v ${sample} ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/hisat2_quant/${sample}
done < ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/SRR_Acc_List.txt