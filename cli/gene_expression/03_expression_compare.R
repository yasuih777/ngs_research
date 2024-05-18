# usr/bin/Rscript

library("dplyr")
library("ggplot2")
library("sleuth")
library("stringr")

# local variables
sample_master_path <- stringr::str_c(
    config$utils$data_dir,
    config$species$reference_genome,
    "/genome_expression/data/SraRunTable.txt"
)
gene_master_path <- stringr::str_c(
    config$utils$data_dir,
    config$species$reference_genome,
    "/reference/gene_master.tsv"
)
output_directory_path <- stringr::str_c(
    config$utils$data_dir,
    config$species$reference_genome,
    "/genome_expression/output"
)
dir.create(
    stringr::str_c(output_directory_path, "/table"),
    recursive=TRUE,
    showWarnings = FALSE
)
dir.create(
    stringr::str_c(output_directory_path, "/figure/identity_gene"),
    recursive=TRUE,
    showWarnings = FALSE
)

# prepare master table
sample_master <- read.table(
    sample_master_path,
    sep = ",",
    header = TRUE
)
gene_master <- read.table(
    gene_master_path,
    sep = "\t",
    header = TRUE
)

# transform sample_table for sleuth
sample_table <- data.frame(
    sample = sample_master$Run,
    control = stringr::str_split(
        sample_master$treatment, ", ", simplify = TRUE
    )[,2],
    path = stringr::str_c(
        config$utils$data_dir,
        config$species$reference_genome,
        "/genome_expression/quant/", sample_master$Run
    )
)

# quant gene expresion
log_info("Quantity gene expression")
quant_prep <- sleuth_prep(
    sample_table,
    extra_bootstrap_summary = TRUE,
    target_mapping = gene_master,
    aggregation_column = "gene_id",
    gene_mode = TRUE
)
quant_table <- kallisto_table(quant_prep)
# merge gene_master
quant_table <- merge(
    quant_table,
    gene_master[c("gene_id", "gene_name")],
    by.x = "target_id",
    by.y = "gene_id"
)
write.table(
    quant_table,
    file = stringr::str_c(output_directory_path, "/table/quant_table.tsv"),
    append = FALSE,
    quote = FALSE,
    sep = "\t",
    row.names = FALSE,
)

# likehood ratio test
so <- sleuth_fit(quant_prep, ~control, "full")
lrt <- sleuth_fit(so, ~1, "reduced")
lrt <- sleuth_lrt(lrt, "reduced", "full")
lrt_table <- sleuth_results(
    lrt, "reduced:full", "lrt", show_all = FALSE
) |> dplyr::arrange(pval)
write.table(
    lrt_table,
    file = stringr::str_c(output_directory_path, "/table/lrt_table.tsv"),
    quote = FALSE,
    sep = "\t",
    row.names = FALSE,
)

# visualization
lower_gene <- dplyr::top_n(
    lrt_table, -config$project$genome_expression$upper_gene, pval
)
# plot identity boxplot
for (gene in lower_gene$target_id){
    fig <- sleuth::plot_bootstrap(
        lrt,
        gene,
        units="est_counts"
    )
    log_info(stringr::str_c("Saved: identity boxplot: ", gene))
    ggplot2::ggsave(
        stringr::str_c(
            output_directory_path, "/figure/identity_gene/", gene, ".png"
        ),
        fig
    )
}
# plot clustering heatmap
fig <- sleuth::plot_transcript_heatmap(lrt, lower_gene$target_id, units = "tpm")
log_info(stringr::str_c("Saved: clustering heatmap"))
ggplot2::ggsave(
    stringr::str_c(
        output_directory_path, "/figure/clustering.png", gene, ".png"
    ),
    fig
)