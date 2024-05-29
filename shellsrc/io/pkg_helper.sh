#!/bin/bash

: '
check version: ${utils_data_dir}pkg/
'

# config variable
source ./shellsrc/io/yaml_helper.sh

# sra-toolkit items
prefetch=${utils_data_dir}pkg/sratoolkit.3.1.0-centos_linux64/bin/prefetch
fasterq_dump=${utils_data_dir}pkg/sratoolkit.3.1.0-centos_linux64/bin/fasterq-dump

# FastQC item
fastqc=${utils_data_dir}pkg/FastQC/fastqc

# hisat2
hisat2=${utils_data_dir}pkg/hisat2-2.2.1

# RSEM item
rsem_prepare_reference=${utils_data_dir}pkg/RSEM-1.3.3/rsem-prepare-reference
