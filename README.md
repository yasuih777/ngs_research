# Learning NGS analysis

DRY analysis for Oryza sativa!

# Requirement
OS: Ubuntu 22.04.3 LTS

# Installation

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

## package setup
1. install R
```shell
make install_r
```

2. install shell command
- reference genome install
```shell
make install_sratoolkit
```
- gene expressin
```shell
make install_kallisto
```

# Usage

1. this project has multi format clis (shell script, R, Python), so support execute cli.
    - {script path} in [`cli`](./cli/) directory.

```shell
bash shellsrc/utils/script_execute.sh {script path}
```

## Pipeline

Execute everything except reference in numerical order 

| pipeline | description | code link | remarks |
| --- | --- | --- | --- |
| reference | manage reference genome data to install | [code](./cli/reference/) | [doc](./doc/reference_genome.md) | 
| gene expression | gene expression analysis | [code](./cli/gene_expression/) |  |

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
- bash shell
    - [parse_yaml](https://github.com/mrbaseman/parse_yaml): a simple yaml parser implemented in bash