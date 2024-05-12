# Learning NGS analysis

DRY analysis for Oryza sativa!

# Requirement
OS: Ubuntu 22.04.3 LTS

# Installation

## Setup Miniconda
1. install Miniconda
```shell
make install_miniconda
```

2. setting Miniconda
```shell
make update_conda_channel
make create_environment
# optional
make install_conda_extra
```

## Auto activate for conda environment
1. kill activation of "base" environment
```shell
conda deactivate
conda config --set auto_activate_base false
```

2. automate activation of project environment
    1. make `.conda_config` and input {env-name} only
    2. add special snippet in `~/.bashrc`
    3. when you use `cd` to move project file, activate project environment

edit `~/.bashrc`
```shell
vi ~/.bashrc
```

add this snippet
```
# >>> automatic conda activate >>>
export CONDACONFIGDIR=""
cd() { builtin cd "$@" &&
if [ -f $PWD/.conda_config ]; then
    export CONDACONFIGDIR=$PWD
    conda activate $(cat .conda_config)
elif [ "$CONDACONFIGDIR" ]; then
    if [[ $PWD != *"$CONDACONFIGDIR"* ]]; then
        export CONDACONFIGDIR=""
        conda deactivate
    fi
fi }
# >>> automatic conda activate >>>
```

## External HDD
genome data (FASTA format) have so big memory, so saved those in external HDD.

1. rewrite `DRIVE_NAME` and `MOUNT_PATH` in [Makefile](./Makefile)
- `DRIVE_NAME`: external HDD name
- `MOUNT_PATH`: mount path external HDD

2. mount external HDD
```shell
make mount_drive
```
> [!NOTE]
> need to run as root user, so enter password (use `sudo`).

# Development

## Export conda environment
if you add package in project environment, export to `environment.yaml` (beforem activate environment)
```shell
make export_environment
```

# Reference

## Database
for Oryza sativa
- [EnsemblePlants](https://plants.ensembl.org/index.html)
- [RAP-DB](https://rapdb.dna.affrc.go.jp/index.html)
    - [usage (ja)](https://rapdb.dna.affrc.go.jp/publications/130th_Meeting_JSB.pdf)
- [TENOR](https://tenor.dna.affrc.go.jp/)

## Analysis
- [次世代シークエンサーDRY解析教本](https://www.amazon.co.jp/%E6%AC%A1%E4%B8%96%E4%BB%A3%E3%82%B7%E3%83%BC%E3%82%AF%E3%82%A8%E3%83%B3%E3%82%B5%E3%83%BCDRY%E8%A7%A3%E6%9E%90%E6%95%99%E6%9C%AC-%E6%B8%85%E6%B0%B4%E5%8E%9A%E5%BF%97/dp/478090983X)

## Environment
- [Conda autoactivate](https://github.com/vallops99/Conda-autoactivate-env)
- [parse_yaml](https://github.com/mrbaseman/parse_yaml): a simple yaml parser implemented in bash