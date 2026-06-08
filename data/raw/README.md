# Raw Data

This folder stores the raw dataset used for the AMOD 5430 marathon performance visualization project.

The repository tracks the original ZIP archive so teammates can clone the repository and extract the same raw data locally. Extracted CSV files are intentionally ignored by Git.

The Boston Cutoff Time Tracker dataset is mentioned in the proposal as a possible supplementary dataset, but it is not downloaded or tracked here at this stage because of its size. It can be added later if the analysis requires a Boston qualifying standards comparison.

## Datasets

### 2023 Marathon Results

- Folder: `data/raw/2023-marathon-results/`
- Archive: `2023-marathon-results.zip`
- Source: <https://www.kaggle.com/datasets/runningwithrock/2023-marathon-results>
- License listed by source: CC BY 4.0
- Role in project: Primary dataset
- Downloaded: 2026-06-08

Extracted files:

| File | Rows Including Header | Size | Key Fields |
|---|---:|---:|---|
| `Races.csv` | 641 | 26 KB | `Race`, `Year`, `Date`, `Finishers` |
| `Results.csv` | 429,267 | 24 MB | `Name`, `Race`, `Year`, `Gender`, `Age`, `Finish`, `Age Bracket` |

## Setup for Analysis

After cloning the repository, extract the archive:

```bash
unzip -o data/raw/2023-marathon-results/2023-marathon-results.zip -d data/raw/2023-marathon-results
```

The extracted CSV files should remain uncommitted. They are local working files for analysis.

## Download Commands

The archive was downloaded with:

```bash
curl -L --fail -o data/raw/2023-marathon-results/2023-marathon-results.zip \
  "https://www.kaggle.com/api/v1/datasets/download/runningwithrock/2023-marathon-results"
```

If the direct Kaggle download endpoint changes, use the dataset source pages above.
