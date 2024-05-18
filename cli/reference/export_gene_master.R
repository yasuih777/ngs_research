# usr/bin/Rscript

# dataset checked under snippet
# 1. ensembl <- biomaRt::useEnsembl(
#        biomart=config$species$biomart$biomart,
#        host=config$species$biomart$host
#    )
# 2. biomaRt::listDatasets(ensembl)

library("biomaRt")
library("dplyr")
library("stringr")

# load ensembl data
mart <- biomaRt::useMart(
    biomart = config$species$biomart$biomart,
    dataset = config$species$biomart$dataset,
    host = config$species$biomart$host,
)
# create master
gene_master <- biomaRt::getBM(
    attributes = c(
        "ensembl_transcript_id",
        "ensembl_gene_id",
        "external_gene_name"),
    mart = mart
) |> dplyr::rename(
    target_id = ensembl_transcript_id,
    gene_id = ensembl_gene_id,
    gene_name = external_gene_name,
) |> dplyr::filter(gene_name != "")

# saved master table
write_path <- stringr::str_c(
    config$utils$data_dir,
    config$species$reference_genome,
    "/reference/gene_master.tsv"
)

log_info(stringr::str_c("Saved: master table: ", write_path))
write.table(gene_master, write_path, sep = "\t", row.names = FALSE)
