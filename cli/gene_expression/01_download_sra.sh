#!/bin/bash

: '
Download SRR_Acc_List.txt and SraRunTable.txt from
https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP375151&o=acc_s%3Aa 
and move to {mount drive}/ngs_research/IRGSP-1.0/genome_expression/data,
before this script.
'

# config variable
source ./shellsrc/io/yaml_helper.sh
source ./shellsrc/io/pkg_helper.sh

# install sra files
mkdir -p ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/sra/
${prefetch} \
    --output-directory ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/sra/ \
    --option-file ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/SRR_Acc_List.txt

# install fasta file
${fasterq_dump} \
    ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/sra/SRR* \
    --outdir ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/ \
    --temp ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/ \
    --split-files \
    --progress

# gzip fasta file
pigz -p ${utils_threads} ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/*.fastq

# quality chack
mkdir -p ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/qc
while read sample
do
    ${fastqc} -threads ${utils_threads} --nogroup \
        --outdir ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/qc \
        ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_1.fastq.gz \
        ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/${sample}_2.fastq.gz
done < ${utils_data_dir}${species_reference_genome}/${project_genome_expression_name}/data/SRR_Acc_List.txt