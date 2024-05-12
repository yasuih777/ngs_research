# usr/bin/Rscript

library("biomaRt")
library("dplyr")
library("stringr")

# variables
## dataset checked under snippet
## 1. ensembl <- biomaRt::useEnsembl(biomart=biomart, host=host)
## 2. biomaRt::listDatasets(ensembl)
biomart <- "plants_mart"
dataset <- "osativa_eg_gene"
host <- "https://plants.ensembl.org"

# load ensembl data
mart <- biomaRt::useMart(
    biomart = biomart,
    dataset = dataset,
    host = host,
)
# create master
gene_master <- biomaRt::getBM(
    attributes = c(
        "ensembl_transcript_id",
        "ensembl_gene_id",
        "external_gene_name"),
    mart = mart
) |>
    dplyr::rename(
    transcript_id = ensembl_transcript_id,
    gene_id = ensembl_gene_id,
    gene_name = external_gene_name,
) |>
    dplyr::filter(gene_name != "")
# saved master table
write_path <- stringr::str_c(
    config$utils$data_dir,
    config$species$reference_genome,
    "/reference/",
    "gene_master.csv"
)
write.csv(gene_master, write_path, quote = FALSE, row.names = FALSE)
