#!/bin/bash

# argments
command=$1

# stopped not exist file
if [ ! -e ${command} ]; then
    echo ${command} is not exist
    exit 0
fi

if [ "${command##*.}" = "sh" ]; then
    echo "execute shell script, ${command}"
    bash ${command}
elif [ "${command##*.}" = "R" ]; then
    echo "execute R script, ${command}"
    Rscript ${command}
elif [ "${command##*.}" = "py" ]; then
    echo "execute Python script, ${command}"
    python ${command}
else
    echo "unsupported format"
fi