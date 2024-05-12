#!/bin/bash

source ./shellsrc/io/parse_yaml.sh

# setting YAML variables: ./config/config.yaml
eval $(parse_yaml ./config/config.yaml)