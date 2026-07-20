#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
})

results_path <- "data/raw/2023-marathon-results/Results.csv"
races_path <- "data/raw/2023-marathon-results/Races.csv"
sample_dir <- "data/sample"

if (!file.exists(results_path) || !file.exists(races_path)) {
  stop("Extract the primary dataset archive before creating the sample files.")
}

set.seed(5430)

results_sample <- read_csv(results_path, show_col_types = FALSE) %>%
  group_by(Race) %>%
  group_modify(~slice_sample(.x, n = min(20, nrow(.x)))) %>%
  ungroup() %>%
  mutate(Name = sprintf("Sample Runner %05d", row_number())) %>%
  select(Name, Race, Year, Gender, Age, Finish, `Age Bracket`)

races_sample <- read_csv(races_path, show_col_types = FALSE)

dir.create(sample_dir, recursive = TRUE, showWarnings = FALSE)
write_csv(results_sample, file.path(sample_dir, "Results_sample.csv"))
write_csv(races_sample, file.path(sample_dir, "Races_sample.csv"))

cat("Created", format(nrow(results_sample), big.mark = ","), "anonymous result rows and",
    format(nrow(races_sample), big.mark = ","), "race metadata rows in", sample_dir, "\n")
