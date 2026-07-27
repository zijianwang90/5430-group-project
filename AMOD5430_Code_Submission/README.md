# Visualizing Performance Stratification in 2023 U.S. Marathon Results

This folder contains the source code and an anonymous sample of the data for the
AMOD 5430 final project, *Visualizing Performance Stratification in 2023 U.S.
Marathon Results*.

## Files

- `analysis.R` — data preparation, exploratory summaries, and all six figure groups.
- `data/Results_sample.csv` — anonymous sample of marathon finishers.
- `data/Races_sample.csv` — race dates and field-size metadata.

The sample contains up to 20 finishers per race and is included only to verify that
the complete analysis runs. Therefore, its numerical results will differ from those
reported in the paper, which used the complete 2023 dataset.

## Setup

Install R (version 4.5 or later is recommended), then run this once in R:

```r
install.packages(c("cowplot", "dplyr", "ggplot2", "readr", "scales", "tidyr"))
```

## Run

Open a terminal in this folder and run:

```bash
Rscript analysis.R
```

The script prints summary statistics and creates six PDF files in a new `figures/`
folder.

## Data source

The sample was created from the public **2023 Marathon Results** dataset:
https://www.kaggle.com/datasets/runningwithrock/2023-marathon-results
