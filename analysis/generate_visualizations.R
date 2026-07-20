#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(cowplot)
  library(dplyr)
  library(ggplot2)
  library(readr)
  library(scales)
  library(tidyr)
})

args <- commandArgs(trailingOnly = TRUE)
sample_mode <- "--sample" %in% args

if (sample_mode) {
  results_path <- "data/sample/Results_sample.csv"
  races_path <- "data/sample/Races_sample.csv"
  figure_dir <- "outputs/sample-figures"
  scatter_minimum <- 5
  ranking_minimum <- 10
} else {
  results_path <- "data/raw/2023-marathon-results/Results.csv"
  races_path <- "data/raw/2023-marathon-results/Races.csv"
  figure_dir <- "Paper/figures"
  scatter_minimum <- 25
  ranking_minimum <- 500
}

if (!file.exists(results_path) || !file.exists(races_path)) {
  stop(
    "Input CSV files are missing. Extract the raw archive for the full analysis ",
    "or run with --sample using the included sample files."
  )
}

dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

results <- read_csv(results_path, show_col_types = FALSE)
races <- read_csv(races_path, show_col_types = FALSE) %>%
  mutate(
    Date = as.Date(Date, format = "%m/%d/%y"),
    Month = factor(month.abb[as.integer(format(Date, "%m"))], levels = month.abb),
    `Race size` = case_when(
      Finishers < 100 ~ "Small (<100)",
      Finishers < 500 ~ "Medium (100-499)",
      Finishers < 2000 ~ "Large (500-1,999)",
      TRUE ~ "Major (2,000+)"
    ),
    `Race size` = factor(
      `Race size`,
      levels = c("Small (<100)", "Medium (100-499)", "Large (500-1,999)", "Major (2,000+)")
    )
  )

band_levels <- c("Under 2:45", "2:45-2:59", "3:00-3:59", "4:00-4:59", "5:00+")
age_levels <- c(
  "Under 35", "35-39", "40-44", "45-49", "50-54", "55-59",
  "60-64", "65-69", "70-74", "75-79", "80 and Over"
)

joined <- results %>%
  mutate(
    `Finish time (hours)` = Finish / 3600,
    `Performance band` = case_when(
      Finish < 2.75 * 3600 ~ "Under 2:45",
      Finish < 3 * 3600 ~ "2:45-2:59",
      Finish < 4 * 3600 ~ "3:00-3:59",
      Finish < 5 * 3600 ~ "4:00-4:59",
      TRUE ~ "5:00+"
    ),
    `Performance band` = factor(`Performance band`, levels = band_levels),
    `Age Bracket` = factor(`Age Bracket`, levels = age_levels)
  ) %>%
  left_join(
    races %>% select(Race, Year, Date, Month, Finishers, `Race size`),
    by = c("Race", "Year")
  )

theme_project <- function(base_size = 9) {
  theme_minimal(base_size = base_size, base_family = "Helvetica") +
    theme(
      plot.title = element_text(face = "bold", size = rel(1.1), margin = margin(b = 5)),
      plot.subtitle = element_text(color = "#4D4D4D", margin = margin(b = 8)),
      plot.caption = element_text(color = "#5F5F5F", hjust = 0, size = rel(0.85)),
      axis.title = element_text(face = "bold"),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      legend.title = element_text(face = "bold"),
      legend.position = "bottom",
      strip.text = element_text(face = "bold"),
      plot.margin = margin(8, 10, 8, 8)
    )
}

save_figure <- function(filename, plot, width = 7.15, height = 3.4) {
  ggsave(
    file.path(figure_dir, filename),
    plot,
    width = width,
    height = height,
    units = "in",
    device = cairo_pdf
  )
}

band_colors <- c(
  "Under 2:45" = "#0072B2",
  "2:45-2:59" = "#56B4E9",
  "3:00-3:59" = "#009E73",
  "4:00-4:59" = "#E69F00",
  "5:00+" = "#D55E00"
)

# Figure 1: overall distribution and performance-band composition.
finish_hist <- ggplot(joined, aes(x = `Finish time (hours)`)) +
  geom_histogram(binwidth = 10 / 60, boundary = 0, fill = "#4477AA", color = "white", linewidth = 0.15) +
  geom_vline(xintercept = c(2.75, 3, 4, 5), linetype = "dashed", color = "#555555", linewidth = 0.35) +
  annotate(
    "text", x = c(2.75, 3, 4, 5), y = Inf,
    label = c("2:45", "3:00", "4:00", "5:00"),
    vjust = 1.4, hjust = c(1.1, -0.1, -0.1, -0.1), size = 2.5, color = "#333333"
  ) +
  coord_cartesian(xlim = c(2, 8)) +
  scale_x_continuous(breaks = 2:8, expand = expansion(mult = c(0, 0.01))) +
  scale_y_continuous(labels = label_number(scale = 1e-3, suffix = "k"), expand = expansion(mult = c(0, 0.08))) +
  labs(
    title = "A. Finish-time distribution",
    x = "Finish time (hours)",
    y = "Finishers"
  ) +
  theme_project()

band_summary <- joined %>%
  count(`Performance band`) %>%
  mutate(share = n / sum(n))

band_bar <- ggplot(band_summary, aes(x = share, y = `Performance band`, fill = `Performance band`)) +
  geom_col(width = 0.7, show.legend = FALSE) +
  geom_text(
    aes(label = paste0(comma(n), "  (", percent(share, accuracy = 0.1), ")")),
    hjust = -0.05, size = 2.65
  ) +
  scale_fill_manual(values = band_colors) +
  scale_x_continuous(labels = percent, limits = c(0, max(band_summary$share) * 1.58), expand = c(0, 0)) +
  scale_y_discrete(limits = rev) +
  labs(
    title = "B. Share in each performance band",
    x = "Share of finishers",
    y = NULL
  ) +
  theme_project() +
  theme(panel.grid.major.y = element_blank())

overall_plot <- plot_grid(finish_hist, band_bar, nrow = 1, rel_widths = c(1.08, 0.92))
save_figure("fig1-overall-performance.pdf", overall_plot, height = 3.25)

# Figure 2: demographic distribution and age-by-band composition.
age_gender_summary <- joined %>%
  filter(Gender %in% c("F", "M"), !is.na(`Age Bracket`)) %>%
  group_by(Gender, `Age Bracket`) %>%
  summarise(
    q25 = quantile(`Finish time (hours)`, 0.25),
    median = median(`Finish time (hours)`),
    q75 = quantile(`Finish time (hours)`, 0.75),
    .groups = "drop"
  )

demographic_iqr <- ggplot(
  age_gender_summary,
  aes(x = `Age Bracket`, y = median, color = Gender, group = Gender)
) +
  geom_errorbar(aes(ymin = q25, ymax = q75), width = 0.18, linewidth = 0.45, position = position_dodge(width = 0.35)) +
  geom_line(linewidth = 0.65, position = position_dodge(width = 0.35)) +
  geom_point(size = 1.8, position = position_dodge(width = 0.35)) +
  scale_color_manual(values = c("F" = "#CC6677", "M" = "#4477AA"), labels = c("Women", "Men")) +
  scale_y_continuous(breaks = seq(3, 7, 0.5)) +
  labs(
    title = "A. Median and middle 50% of finish times",
    x = "Age bracket",
    y = "Finish time (hours)",
    color = "Gender"
  ) +
  theme_project() +
  theme(axis.text.x = element_text(angle = 40, hjust = 1), legend.position = "bottom")

age_band <- joined %>%
  filter(Gender %in% c("F", "M"), !is.na(`Age Bracket`)) %>%
  count(Gender, `Age Bracket`, `Performance band`) %>%
  group_by(Gender, `Age Bracket`) %>%
  complete(`Performance band`, fill = list(n = 0)) %>%
  mutate(share = n / sum(n)) %>%
  ungroup()

demographic_heatmap <- ggplot(age_band, aes(x = `Age Bracket`, y = `Performance band`, fill = share)) +
  geom_tile(color = "white", linewidth = 0.3) +
  geom_text(aes(label = percent(share, accuracy = 1)), size = 2.1, color = "#1A1A1A") +
  facet_wrap(~Gender, ncol = 1, labeller = as_labeller(c(F = "Women", M = "Men"))) +
  scale_fill_gradient(low = "#F7FBFF", high = "#2171B5", labels = percent) +
  labs(
    title = "B. Performance-band composition",
    x = "Age bracket",
    y = NULL,
    fill = "Share"
  ) +
  theme_project(base_size = 8.5) +
  theme(
    axis.text.x = element_text(angle = 40, hjust = 1),
    legend.position = "right",
    panel.grid = element_blank()
  )

demographic_plot <- plot_grid(demographic_iqr, demographic_heatmap, nrow = 1, rel_widths = c(0.9, 1.1))
save_figure("fig2-demographic-stratification.pdf", demographic_plot, height = 4.15)

# Figure 3: race-size distribution and performance composition.
race_size_counts <- races %>%
  count(`Race size`) %>%
  complete(`Race size`, fill = list(n = 0))

race_size_bar <- ggplot(race_size_counts, aes(x = `Race size`, y = n)) +
  geom_col(fill = "#4477AA", width = 0.7) +
  geom_text(aes(label = comma(n)), vjust = -0.35, size = 2.7) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
  labs(
    title = "A. Number of races by field size",
    x = NULL,
    y = "Races"
  ) +
  theme_project() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1))

race_size_bands <- joined %>%
  filter(!is.na(`Race size`)) %>%
  count(`Race size`, `Performance band`) %>%
  group_by(`Race size`) %>%
  mutate(share = n / sum(n)) %>%
  ungroup()

race_size_stack <- ggplot(race_size_bands, aes(x = `Race size`, y = share, fill = `Performance band`)) +
  geom_col(width = 0.72) +
  scale_fill_manual(values = band_colors) +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE)) +
  scale_y_continuous(labels = percent, expand = c(0, 0)) +
  labs(
    title = "B. Performance composition by race size",
    x = NULL,
    y = "Share of finishers",
    fill = "Performance band"
  ) +
  theme_project() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1), legend.position = "bottom")

race_size_plot <- plot_grid(race_size_bar, race_size_stack, nrow = 1, rel_widths = c(0.76, 1.24))
save_figure("fig3-race-size-context.pdf", race_size_plot, height = 3.9)

# Figure 4: race size and sub-4 share. A minimum field size reduces unstable percentages.
race_metrics <- joined %>%
  group_by(Race) %>%
  summarise(
    n = n(),
    reported_finishers = first(Finishers),
    median_hours = median(`Finish time (hours)`),
    sub3_share = mean(Finish < 3 * 3600),
    sub4_share = mean(Finish < 4 * 3600),
    .groups = "drop"
  ) %>%
  mutate(plot_size = if (sample_mode) reported_finishers else n)

scatter_data <- race_metrics %>% filter(n >= scatter_minimum)
highlight_races <- c("NYC Marathon", "Chicago Marathon", "Boston Marathon")
scatter_labels <- scatter_data %>% filter(Race %in% highlight_races)

race_scatter <- ggplot(scatter_data, aes(x = plot_size, y = sub4_share)) +
  geom_point(alpha = 0.5, size = 1.5, color = "#4477AA") +
  geom_smooth(method = "loess", formula = y ~ x, se = TRUE, color = "#D55E00", fill = "#F4A582", linewidth = 0.65, alpha = 0.2) +
  geom_point(data = scatter_labels, color = "#B2182B", size = 2.1) +
  geom_text(
    data = scatter_labels,
    aes(label = Race),
    hjust = 1.05,
    vjust = c(-0.6, 1.2, -0.6),
    size = 2.5,
    color = "#333333"
  ) +
  scale_x_log10(labels = label_number(big.mark = ",")) +
  scale_y_continuous(labels = percent, limits = c(0, NA), expand = expansion(mult = c(0, 0.05))) +
  labs(
    title = "Race size and the share of sub-4 finishers",
    subtitle = paste0(
      "Each point is a race with at least ", scatter_minimum,
      " recorded finishers; line shows a LOESS trend"
    ),
    x = "Recorded finishers (log scale)",
    y = "Share finishing under 4 hours"
  ) +
  theme_project()

save_figure("fig4-race-size-sub4.pdf", race_scatter, height = 3.6)

# Figure 5: race calendar by event count and participant volume.
calendar_summary <- races %>%
  group_by(Month) %>%
  summarise(races = n(), finishers = sum(Finishers), .groups = "drop") %>%
  complete(Month, fill = list(races = 0, finishers = 0))

calendar_races <- ggplot(calendar_summary, aes(x = Month, y = races, group = 1)) +
  geom_col(fill = "#4477AA", width = 0.72) +
  geom_text(aes(label = races), vjust = -0.25, size = 2.5) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.12))) +
  labs(title = "A. Races by month", x = NULL, y = "Number of races") +
  theme_project()

calendar_finishers <- ggplot(calendar_summary, aes(x = Month, y = finishers, group = 1)) +
  geom_col(fill = "#009E73", width = 0.72) +
  geom_text(aes(label = label_number(scale = 1e-3, suffix = "k", accuracy = 1)(finishers)), vjust = -0.25, size = 2.5) +
  scale_y_continuous(labels = label_number(scale = 1e-3, suffix = "k"), expand = expansion(mult = c(0, 0.12))) +
  labs(title = "B. Finishers by race month", x = NULL, y = "Finishers") +
  theme_project()

calendar_plot <- plot_grid(calendar_races, calendar_finishers, nrow = 1)
save_figure("fig5-race-calendar.pdf", calendar_plot, height = 3.25)

# Figure 6: top competitive races using a minimum field-size rule.
top_competitive <- race_metrics %>%
  filter(n >= ranking_minimum) %>%
  slice_max(order_by = sub3_share, n = 12, with_ties = FALSE) %>%
  arrange(sub3_share) %>%
  mutate(Race = factor(Race, levels = Race))

competitive_plot <- ggplot(top_competitive, aes(x = sub3_share, y = Race)) +
  geom_segment(aes(x = 0, xend = sub3_share, yend = Race), color = "#BDBDBD", linewidth = 0.7) +
  geom_point(color = "#0072B2", size = 2.5) +
  geom_text(
    aes(label = paste0(percent(sub3_share, accuracy = 0.1), "  n=", comma(n))),
    hjust = -0.08,
    size = 2.55
  ) +
  scale_x_continuous(labels = percent, limits = c(0, max(top_competitive$sub3_share) * 1.42), expand = c(0, 0)) +
  labs(
    title = "Races with the highest share of sub-3 finishers",
    subtitle = paste0("Restricted to races with at least ", ranking_minimum, " recorded finishers"),
    x = "Share finishing under 3 hours",
    y = NULL
  ) +
  theme_project() +
  theme(panel.grid.major.y = element_blank())

save_figure("fig6-competitive-races.pdf", competitive_plot, height = 4.15)

cat("\nDataset summary\n")
cat("Mode:", ifelse(sample_mode, "sample", "full"), "\n")
cat("Runner records:", comma(nrow(results)), "\n")
cat("Race records:", comma(nrow(races)), "\n")
cat("Unknown/invalid ages (Age < 10 or missing):", comma(sum(is.na(results$Age) | results$Age < 10)), "\n")
cat("Gender X/U records:", comma(sum(results$Gender %in% c("X", "U"))), "\n")
cat("Median finish:", round(median(joined$`Finish time (hours)`), 2), "hours\n")
cat("Sub-3 share:", percent(mean(joined$Finish < 3 * 3600), accuracy = 0.1), "\n")
cat("Sub-4 share:", percent(mean(joined$Finish < 4 * 3600), accuracy = 0.1), "\n")
cat("Sub-5 share:", percent(mean(joined$Finish < 5 * 3600), accuracy = 0.1), "\n")
cat("Races meeting scatterplot minimum:", comma(nrow(scatter_data)), "\n")
cat("Race-size band shares:\n")
print(race_size_bands %>% select(`Race size`, `Performance band`, share) %>% pivot_wider(names_from = `Performance band`, values_from = share))
cat("\nMonthly summary:\n")
print(calendar_summary)
cat("\nTop competitive races:\n")
print(top_competitive %>% select(Race, n, sub3_share, sub4_share))
