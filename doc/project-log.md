# Project Log

## 2026-06-13

### Proposal bibliography and citation rendering

- Fixed malformed PDF rendering for the Rock dataset entries (`rock2023marathon`, `rock2025boston`) in `Proposal/references.bib`:
  - Replaced non-standard BibTeX fields `howpublished` and `note` with CSL-compatible `publisher` and `urldate`.
  - This corrected missing punctuation before URLs (e.g., `Running with Rock` now renders with a proper period before the link).
- Switched proposal bibliography style from Quarto/pandoc default Chicago author-date to APA 7:
  - Added `Proposal/apa.csl`.
  - Added `csl: apa.csl` to `Proposal/project-proposal-draft.qmd`.
  - APA now repeats author names for same-author entries instead of using the Chicago same-author em-dash (`———`) seen for the second Rock citation.
- Committed and pushed the citation-style changes in `6adff0c` (`Switch proposal references to APA style`).

### Proposal content review and wording alignment

- Revised the closing paragraph in **Expected Results**:
  - Removed the explicit contrast with predictive modeling.
  - Replaced it with a shorter tentative-outcome statement focused on visual findings across demographic and race contexts.
- Aligned visualization tooling with the static-output scope:
  - Removed `Plotly` from **Tools and Libraries**.
  - Kept `matplotlib` and `seaborn` only, consistent with the proposal's `static visualizations` language.
- Aligned performance-band wording across sections:
  - Added `elite or near-elite` to the abstract performance-band list so it matches the EDA plan and the title's recreational-to-elite framing.
- Standardized dataset population terminology:
  - Changed dataset/analysis references from `runners` to `finishers` throughout `Proposal/project-proposal-draft.qmd` (abstract, problem, intended contribution, EDA plan, research questions, expected results).
  - Updated the matching research question in `README.md`.
  - Left general descriptive phrases such as `a runner's age group` and `faster runners` where they refer to race competitiveness rather than dataset records.
- Re-rendered `Proposal/project-proposal-draft.pdf` after each proposal edit; final draft remains three pages.

### README optimization

- Decided to keep the `elite or near-elite` band naming rule (did not collapse it to a single `elite` label).
- Updated `README.md` for consistency with the proposal:
  - Changed the overview wording from `near-elite runner groups` to `elite or near-elite finisher groups`.
  - Removed the predictive-modeling note and replaced it with a visualization-focused expected-output statement.
  - Reworked the performance-band table into explicit mutually exclusive finish-time intervals (e.g., Sub-3 = 2:45-2:59, Sub-4 = 3:00-3:59) and noted that each finisher belongs to exactly one band; changed `runners` to `finishers` in the interpretation column.
  - Updated the repository structure tree to include `Proposal/apa.csl`, `.gitignore`, and the `data/external/` and `data/processed/` working directories, with a note that processed/external/extracted CSV data is untracked.

### Files touched in this session

- `Proposal/references.bib`
- `Proposal/apa.csl` (new)
- `Proposal/project-proposal-draft.qmd`
- `Proposal/project-proposal-draft.pdf`
- `README.md`
- `doc/project-log.md`

## 2026-06-08

- Created the first Quarto proposal draft for the AMOD 5430 Data Visualization course project.
- Selected "From Recreational to Elite: Performance Stratification in Marathon Results" as the working topic.
- Chose the 2023 Marathon Results Kaggle dataset as the primary dataset.
- Added the Boston Cutoff Time Tracker dataset as an optional supplementary dataset for Boston qualifying standards comparison.
- Added initial bibliography entries for the primary dataset, supplementary dataset, course visualization reference, and an age-related marathon performance study.
- Moved proposal-related files from `doc/` to `Proposal/` and verified that the Quarto draft renders successfully from the new location.
- Added the project root `README.md` with the project overview, research questions, data sources, planned visualizations, team responsibilities, repository structure, and proposal rendering instructions.
- Removed interactive dashboard language from the proposal and README to reflect the current static visualization project scope.
- Downloaded the primary 2023 Marathon Results dataset into `data/raw/`, added raw data documentation, and configured Git to track the source ZIP archive while ignoring extracted CSV files.
- Kept the Boston Cutoff Time Tracker dataset as an optional proposal data source, but did not store it locally in the repository because of file size; it can be added later if the analysis requires it.
