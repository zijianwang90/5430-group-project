# AMOD 5430 Data Visualization Project

## Project Overview

This repository contains the course project materials for **AMOD 5430: Data Visualization**.

Working title:

**From Recreational to Elite: Performance Stratification in Marathon Results**

The project studies how marathon performance is distributed across recreational, competitive, and near-elite runner groups. The main goal is to use exploratory data analysis and data visualization to explain how finish-time performance bands vary across age, gender, and race contexts.

## Research Focus

The project is centered on the following questions:

1. How are marathon finishers distributed across performance bands from recreational to competitive and near-elite levels?
2. How do age and gender relate to finish-time distributions and performance-band membership?
3. Which races show higher proportions of competitive finishers, such as sub-3 or sub-4 runners?
4. If supplementary data is used later, how do fixed performance bands compare with Boston qualifying standards across age and gender groups?

The expected output is a reproducible exploratory analysis with clear static visualizations. Predictive modeling is optional and is not the core objective of the current project direction.

The raw primary dataset archive has been downloaded into `data/raw/`. See `data/raw/README.md` for file inventory, source links, and extraction commands. The Boston Cutoff Time Tracker dataset is kept as a proposal option, but it is not stored locally in this repository at this stage because of its size.

## Data Sources

### Primary Dataset

**2023 Marathon Results, Kaggle**

- Source: <https://www.kaggle.com/datasets/runningwithrock/2023-marathon-results>
- Description: Individual marathon results from 641 marathon races in the United States in 2023.
- Approximate size: 429,000 finishers.
- Relevant fields: gender, age, finish time, and race-level information.
- Planned use: Main dataset for finish-time distributions, demographic comparisons, performance bands, and race-level performance profiles.

### Optional Future Dataset

**Boston Cutoff Time Tracker Dataset**

- Source: <https://runningwithrock.com/boston-cutoff-time-dataset/>
- Description: Marathon results, race information, and Boston qualifying standards used for Boston cutoff analysis.
- Planned use if added later: Optional comparison between fixed performance bands, such as sub-3 and sub-4, and Boston qualifying standards by age and gender.
- Repository status: Not downloaded or tracked in the repository at this stage because the dataset archive is relatively large.

## Planned Performance Bands

The analysis will derive performance groups from finish time. Initial bands may include:

| Band | Example Definition | Interpretation |
|---|---:|---|
| Elite / near-elite | Under 2:30 or under 2:45 | High-level runners |
| Sub-3 | Under 3:00 | Competitive runners |
| Sub-4 | 3:00-3:59 | Strong recreational runners |
| Sub-5 | 4:00-4:59 | Recreational finishers |
| 5+ hours | 5:00 or slower | Recreational finishers |

These thresholds may be refined after initial EDA to avoid misleading categories or very small groups.

## Planned Visualizations

Possible visualizations include:

- Finish-time histograms and density plots.
- Boxplots or violin plots by age group and gender.
- Age group by performance band heatmaps.
- Stacked bar charts showing demographic composition by performance band.
- Race-level scatterplots comparing race size with sub-3 or sub-4 proportions.
- Optional Boston qualifying margin comparisons if the supplementary dataset is added later.

## Team Members

| Team Member | Responsibilities |
|---|---|
| Zijian Wang | Project coordination, background research, problem formulation, proposal/report writing, and coding support. |
| Yuanyuan Zhang | Exploratory data analysis, visualization design, interpretation of findings, and contribution to the final report. |
| Xiaohan Zhang | Data ingestion, data cleaning, analysis pipeline development, and methodology/report writing. |
| Yihe Wang | Code implementation, data processing support, visualization implementation, and testing/reproducibility support. |

## Repository Structure

```text
.
├── AMOD-5430H-A_ Data Visualization (2026SU - Peterborough Campus).pdf
├── Proposal/
│   ├── AMOD5430-Project-Proposal-Template.docx
│   ├── project-proposal-draft.qmd
│   ├── project-proposal-draft.pdf
│   ├── project-proposal-last-term.pdf
│   └── references.bib
├── data/
│   └── raw/
│       ├── 2023-marathon-results/
│       │   └── 2023-marathon-results.zip
│       └── README.md
├── doc/
│   └── project-log.md
├── project.jpg
└── README.md
```

## Data Setup

The primary raw ZIP archive is stored in `data/raw/`. To prepare the local CSV files for analysis:

```bash
unzip -o data/raw/2023-marathon-results/2023-marathon-results.zip -d data/raw/2023-marathon-results
```

Extracted CSV files are ignored by Git and should remain local working files.

## Proposal

The first proposal draft is available in:

- `Proposal/project-proposal-draft.qmd`
- `Proposal/project-proposal-draft.pdf`

To render the proposal from the project root:

```bash
cd Proposal
quarto render project-proposal-draft.qmd
```

## Project Notes

- Course-related documents and project notes are stored in `doc/` or `Proposal/`.
- The current proposal uses the 2023 Marathon Results dataset as the main dataset.
- The Boston Cutoff Time Tracker dataset remains an optional future data source, but it is not stored locally in this repository.
- Major project decisions and updates should be recorded in `doc/project-log.md`.
