# Sample Data

This folder contains a small, anonymous sample that allows the analysis code to run without the full Kaggle dataset.

- `Results_sample.csv`: up to 20 randomly selected result rows per race, using a fixed random seed. Runner names are replaced with generated sample identifiers.
- `Races_sample.csv`: race metadata needed to join dates and field sizes.

The sample is intended only for testing the code. Figures and findings in the paper are generated from the complete dataset in `data/raw/2023-marathon-results/`.

Regenerate the sample from the project root with:

```bash
Rscript analysis/create_sample_data.R
```
