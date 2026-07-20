# Formal Project Outline

Working title:

**From Recreational to Elite: Performance Stratification in Marathon Results**

## Instructor Feedback to Address

The proposal was approved. The instructor suggested adding a more detailed discussion of dataset features beyond performance level, age, and gender. The formal project should therefore explicitly analyze and discuss additional variables from the dataset, especially race-level context.

Key expansion:

- Do not frame the project only around `performance band`, `Age`, and `Gender`.
- Add race-level features: `Race`, `Date`, `Finishers`.
- Derive additional analytical variables: race size group, race month/season, field competitiveness, and race-level performance profile.
- Discuss data quality issues: unknown age brackets, non-binary/unknown gender codes, implausible age values, very small races, and extreme finish times.

## Available Dataset Features

Primary dataset:

**2023 Marathon Results**

Runner-level table: `Results.csv`

| Field | Role in Analysis |
|---|---|
| `Name` | Runner identifier; not central to analysis and should not be emphasized in visual outputs. |
| `Race` | Links each runner to a specific marathon; supports race-level comparison. |
| `Year` | Constant value in the primary dataset, 2023; confirms cross-sectional rather than longitudinal scope. |
| `Gender` | Demographic grouping variable. Values include `M`, `F`, `X`, and `U`. |
| `Age` | Numeric demographic variable; supports age distribution and age-performance analysis. |
| `Finish` | Finish time in seconds; main quantitative outcome. |
| `Age Bracket` | Provided categorical age grouping; supports heatmaps and group-level comparisons. |

Race-level table: `Races.csv`

| Field | Role in Analysis |
|---|---|
| `Race` | Race name and join key to runner-level records. |
| `Year` | Race year, 2023. |
| `Date` | Race date; can be converted into month or season. |
| `Finishers` | Race size; supports comparison between small, medium, large, and major races. |

Derived variables to create:

| Derived Variable | Source Fields | Purpose |
|---|---|---|
| Finish time in hours | `Finish` | Makes results easier to interpret. |
| Performance band | `Finish` | Groups runners into elite/near-elite, sub-3, sub-4, sub-5, and 5+ hour categories. |
| Race size group | `Finishers` | Compares small, medium, large, and major races. |
| Race month | `Date` | Shows seasonal timing of races and performance distribution by month. |
| Race season | `Date` | Aggregates races into winter, spring, summer, and fall. |
| Race competitiveness score | Race-level share of sub-3/sub-4 finishers | Identifies races with more competitive fields. |
| Median finish time by race | `Race`, `Finish` | Summarizes race-level performance profile. |

## Recommended Formal Paper Structure

### Abstract

Briefly summarize:

- The problem: marathon results need more than rankings or average finish times to explain runner performance structure.
- The data: 2023 U.S. marathon results, 641 races, about 429,000 finishers.
- The method: EDA and static data visualization.
- The contribution: visual explanation of how performance bands vary by demographics and race context.
- Main expected findings: performance stratification differs by age, gender, race size, and race competitiveness.

### 1. Introduction

Purpose:

Introduce why marathon performance stratification is a useful data visualization problem.

Points to cover:

- Marathon finish times are often interpreted through simple thresholds, such as sub-3 or sub-4.
- These thresholds are easier to understand when placed in demographic and race context.
- The project focuses on visual EDA rather than prediction.
- State the central research goal:

> To visualize how marathon performance is distributed across recreational, competitive, and near-elite finishers, and how these distributions vary by demographic and race-level features.

Suggested research questions:

1. How are 2023 U.S. marathon finishers distributed across performance bands?
2. How do age and gender relate to finish-time distributions?
3. How do race-level features, especially race size and race date, shape performance patterns?
4. Which races appear more competitive based on their share of faster finishers?

### 2. Related Work and Visualization Background

Purpose:

Connect the project to marathon performance literature and data visualization principles.

Suggested content:

- Use Leyk et al. to justify analyzing age-related endurance performance.
- Use Stephen Few's *Show Me the Numbers* to justify clear quantitative display choices.
- Briefly explain why distribution plots, heatmaps, and race-level comparisons are appropriate.

Keep this section concise. The formal report should not become a sports science literature review; the course focus is data visualization.

### 3. Dataset Description

Purpose:

Respond directly to the instructor's feedback by discussing the full dataset structure.

Subsections:

#### 3.1 Data Source

- Identify the 2023 Marathon Results dataset.
- Explain that it contains two related tables: runner-level results and race-level metadata.
- Clarify that the project is cross-sectional for 2023, not a longitudinal study.

#### 3.2 Runner-Level Features

Discuss:

- `Race`
- `Gender`
- `Age`
- `Age Bracket`
- `Finish`

Explain that `Name` will not be used analytically except as a row identifier, because the project focuses on aggregated patterns rather than individual runners.

#### 3.3 Race-Level Features

Discuss:

- `Race`
- `Date`
- `Finishers`

Emphasize that these fields allow the project to move beyond demographic analysis:

- `Race` allows event-level comparison.
- `Date` allows month/season analysis.
- `Finishers` allows race-size classification.

#### 3.4 Derived Features

List the derived features:

- Finish time in hours.
- Performance band.
- Race size group.
- Race month and season.
- Race-level median finish time.
- Race-level sub-3/sub-4/sub-5 percentages.

#### 3.5 Data Quality and Scope

Discuss:

- Age has unusual values, including `-1`, so age cleaning rules are needed.
- `Age Bracket` includes `Unknown`.
- `Gender` includes `X` and `U`; these should be retained or discussed carefully, but small group sizes may limit some visual comparisons.
- Some races are very small, with only a few finishers; race-level analysis may need a minimum finisher threshold.
- Finish time outliers should be checked rather than automatically removed.

### 4. Methodology

Purpose:

Explain the reproducible EDA workflow.

Subsections:

#### 4.1 Data Cleaning

Planned steps:

- Load `Results.csv` and `Races.csv`.
- Convert `Finish` from seconds to hours.
- Parse `Date` into month and season.
- Handle missing, unknown, or implausible age values.
- Join runner-level records with race-level metadata using `Race` and `Year`.
- Create race size groups.

#### 4.2 Performance Band Definition

Initial bands:

| Band | Definition |
|---|---|
| Elite / near-elite | Under 2:45 |
| Sub-3 | 2:45 to under 3:00 |
| Sub-4 | 3:00 to under 4:00 |
| Sub-5 | 4:00 to under 5:00 |
| 5+ hours | 5:00 or slower |

Note:

The exact elite/near-elite threshold can be refined after initial EDA. The final paper should clearly explain the selected thresholds.

#### 4.3 Visualization Design

Explain why each chart type is used:

- Histogram/density plot: overall finish-time distribution.
- Boxplot/violin plot: compare distributions by age group and gender.
- Heatmap: show age group by performance band patterns.
- Stacked bar chart: show band composition by gender or race size.
- Scatterplot: compare race size with race competitiveness.
- Ranked bar chart: identify races with high shares of sub-3/sub-4 runners.
- Calendar/month chart: show race timing and seasonal distribution.

### 5. Exploratory Results

This should be the main body of the final project.

Recommended subsections and figures:

#### 5.1 Overall Performance Distribution

Possible figures:

- Histogram of finish time in hours.
- Density plot of finish time.
- Bar chart of runners by performance band.

Main message:

Show where most finishers cluster and how large the competitive tail is.

#### 5.2 Demographic Stratification

Possible figures:

- Finish-time distribution by gender.
- Boxplot or violin plot by age bracket.
- Heatmap of age bracket by performance band.

Main message:

Show how age and gender relate to performance distribution without reducing the analysis to simple averages.

#### 5.3 Race Size and Race Context

Possible figures:

- Distribution of race sizes.
- Race size group vs performance band composition.
- Race size vs sub-3/sub-4 percentage scatterplot.

Main message:

Address the instructor's feedback by showing that race context matters. Large races and small races may have different participant structures and competitive profiles.

#### 5.4 Race Date, Month, and Season

Possible figures:

- Number of races by month.
- Number of finishers by month.
- Median finish time or performance band share by month/season.

Main message:

Use `Date` as a feature, not just metadata. This can show whether the race calendar is concentrated in certain seasons and whether race timing is associated with different participant or performance profiles.

#### 5.5 Race-Level Competitiveness

Possible figures:

- Ranked races by sub-3 percentage.
- Ranked races by median finish time.
- Scatterplot of finishers vs median finish time, with point color showing sub-4 percentage.

Main message:

Some races may attract more competitive fields, while others may show broader recreational participation. This section makes the project more than a demographic analysis.

### 6. Discussion

Purpose:

Interpret the visualization findings.

Points to cover:

- What the visualizations reveal about the structure of marathon performance.
- How demographic and race-level features change interpretation.
- Why fixed thresholds such as sub-3 and sub-4 are useful but incomplete.
- How very large races affect aggregate patterns.
- Whether small races should be interpreted cautiously.

### 7. Limitations

Important limitations:

- The dataset covers only U.S. marathons in 2023.
- It does not support long-term trend analysis.
- The dataset does not include course elevation, weather, runner training, or split times.
- Race-level analysis may be affected by small races.
- Age and gender fields contain unknown or unusual values.
- Boston Cutoff Time Tracker remains an optional future dataset and is not included in the current local data package.

### 8. Conclusion

Summarize:

- The project visualizes marathon performance stratification across individuals and race contexts.
- The main contribution is a clear EDA-based explanation of how recreational, competitive, and near-elite groups are distributed.
- Race-level features such as race size and date strengthen the analysis beyond age/gender/performance band.
- Future work could add Boston qualifying standards, weather, elevation, or pacing split data.

### References

Include:

- 2023 Marathon Results dataset.
- Boston Cutoff Time Tracker dataset, if retained as optional future work in the final paper.
- Leyk et al. age-related marathon performance paper.
- Stephen Few's *Show Me the Numbers* or another visualization design reference.

## Suggested Figure List

Minimum useful figure set:

1. Overall finish-time histogram.
2. Performance band share bar chart.
3. Finish-time distribution by gender.
4. Age bracket by performance band heatmap.
5. Race size distribution.
6. Race size group by performance band stacked bar chart.
7. Race size vs sub-4 percentage scatterplot.
8. Races/finishers by month.
9. Ranked race competitiveness chart.

Optional figure set:

1. Median finish time by race month.
2. Top 20 races by sub-3 percentage, filtered to races with a minimum finisher count.
3. Gender composition by race size group.
4. Age distribution by race size group.

## Suggested Work Plan

### Zijian Wang

- Coordinate paper structure and writing.
- Draft Introduction, Problem, Discussion, and Conclusion.
- Help define performance bands and race context variables.

### Yuanyuan Zhang

- Lead visualization design.
- Build and interpret demographic and performance-band charts.
- Write exploratory results for age/gender/performance sections.

### Xiaohan Zhang

- Lead data ingestion and cleaning.
- Join runner-level and race-level data.
- Create derived variables and document cleaning decisions.

### Yihe Wang

- Support code implementation.
- Build reproducible scripts/notebooks for chart generation.
- Help test outputs and organize figures for the final report.

## Immediate Next Steps

1. Create a reproducible analysis notebook or script.
2. Load and validate `Results.csv` and `Races.csv`.
3. Create derived variables: finish hours, performance band, month, season, race size group.
4. Produce the first 4 exploratory figures.
5. Decide whether very small races should be excluded from race-level competitiveness charts.
6. Start drafting the Data Description and Methodology sections using this outline.
