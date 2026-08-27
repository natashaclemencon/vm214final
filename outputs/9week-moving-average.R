# Write the code to process and visualize the data
#(a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N
# 1988 - 1995 , across four sites

# Loading package and moving average functio

library(tidyverse)
source("R/moving-average.R")

# Loading in raw data

BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP <- read_csv("data/RioMameyesPuenteRoto.csv")

# Calculating moving average for each site

bq1_result <- moving_average(BQ1)
bq2_result <- moving_average(BQ2)
bq3_result <- moving_average(BQ3)
rmp_result <- moving_average(RMP)

#Assigning variable to each sample site

bq1_result$Sample_ID <- "BQ1"
bq2_result$Sample_ID <- "BQ2"
bq3_result$Sample_ID <- "BQ3"
rmp_result$Sample_ID <- "RMP"


# Binding the four data frames
BPR <- bind_rows(bq1_result, bq2_result, bq3_result, rmp_result)

#Filtering for dates 1988 - 1995, Sample_ID and 5 ions
bpr_ions <- BPR |>
  filter(window_start >= "1986-05-16" & window_start < "1995-01-03") |>
  select(window_start, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`)

# Pivoting to long tidy form for visualization

bpr_long <- bpr_ions |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (mg/L)"
  )

# Visualizing analysis on stacked graphs, each site is coded by color
bpr_long |>
  ggplot(
    mapping = aes(
      x = window_start,
      y = `Concentration (mg/L)`,
      color = Sample_ID
    )
  ) +
  geom_point() +
  geom_line() +
  labs(
    title = "Ion Concentration",
    x = "Year",
    y = "Concentration",
    legend = "Sample Site"
  ) +
  facet_wrap(~Ion, scales = "free", ncol = 1) +
  theme(
    plot.title = element_text(hjust = 0.5)
  ) +
  scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash"))
