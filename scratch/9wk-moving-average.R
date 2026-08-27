# Write the code to process and visualize the data
#(a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N
# 1988 - 1995 , across four sites
# Spaghetti code

library(tidyverse)
source("R/moving-average.R")

BQ1 <- read_csv("vm214final/data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("vm214final/data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("vm214final/data/QuebradaCuenca3-Bisley.csv")
RMP <- read_csv("vm214final/data/RioMameyesPuenteRoto.csv")

glimpse(BQ1)
glimpse(BQ2)
glimpse(BQ3)
glimpse(RMP)

# Plotting only 1 varible from BQ1
BQ1 |>
  ggplot(
    mapping = aes(
      x = Sample_Date,
      y = K,
    )
  ) +
  geom_point() +
  labs(
    title = "K Concentration",
    x = "Year",
    y = "Concentration"
  )

# Joining Dataframes into 1
# Variables needed
# Sample_Date , K, `NO3-N`, Mg, Ca, `NH4-N`

BPR <- bind_rows(BQ1, BQ2, BQ3, RMP)


#Testing for correct Sample_Date
BPR_SD <- BPR |>
  filter(Sample_Date >= "1988-01-05" & Sample_Date < "1995-01-03")

glimpse(BPR_SD)

summary(BPR_SD$Sample_Date)

# Filtering to Sample Date, Site, and Ions only
bpr_ions <- BPR |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03") |>
  select(Sample_Date, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`)

summary(bpr_ions$Sample_Date)


#Creating empty tibble with apprpriate columns and windows for 1 site
bpr_smoothed <- tibble(
  window_start = seq(
    bpr_ions$Sample_Date[1],
    bpr_ions$Sample_Date[nrow(bpr_ions)],
    by = "9 weeks"
  ),
  K = NA,
  `NO3-N` = NA,
  Mg = NA,
  Ca = NA,
  `NH4-N` = NA
)
bpr_smoothed


#Creating empty tibble with apprpriate columns and windows for 4 sites

bpr_smoothed <- tibble(
  window_start = seq(
    bpr_ions$Sample_Date[1],
    bpr_ions$Sample_Date[nrow(bpr_ions)],
    by = "9 weeks"
  ),
  K = NA,
  `NO3-N` = NA,
  Mg = NA,
  Ca = NA,
  `NH4-N` = NA
)
bpr_smoothed

# Calculating mean and inserting into tibble
for (i in 1:nrow(bpr_smoothed)) {
  w1 <- bpr_smoothed$window_start[i]
  w2 <- w1 + 63

  K <- bpr_ions$K[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2 & bpr_ions
  ]
  NO3N <- bpr_ions$`NO3-N`[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2
  ]
  Mg <- bpr_ions$Mg[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  Ca <- bpr_ions$Ca[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  NH4N <- bpr_ions$`NH4-N`[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2
  ]

  bpr_smoothed$K[i] <- mean(K, na.rm = TRUE)
  bpr_smoothed$`NO3-N`[i] <- mean(NO3N, na.rm = TRUE)
  bpr_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  bpr_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  bpr_smoothed$`NH4-N`[i] <- mean(NH4N, na.rm = TRUE)
}


#### Broken Code
for (i in 1:nrow(bpr_smoothed)) {
  w <- bpr_smoothed$window_start[i]
  w2 <- w + 63

  K <- bpr_ions$K[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  NO3N <- bpr_ions$`NO3-N`[
    bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2
  ]
  Mg <- bpr_ions$Mg[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  Ca <- bpr_ions$Ca[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  NH4N <- bpr_ions$`NH4-N`[
    bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2
  ]

  bpr_smoothed$K[i] <- mean(K, na.rm = TRUE)
  bpr_smoothed$`NO3-N`[i] <- mean(NO3N, na.rm = TRUE)
  bpr_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  bpr_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  bpr_smoothed$`NH4-N`[i] <- mean(NH4N, na.rm = TRUE)
}


### end of broken code

### Correct Code
for (i in 1:nrow(bpr_smoothed)) {
  w1 <- bpr_smoothed$window_start[i]
  w2 <- w1 + 63

  K <- bpr_ions$K[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2 & bpr_ions
  ]
  NO3N <- bpr_ions$`NO3-N`[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2
  ]
  Mg <- bpr_ions$Mg[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  Ca <- bpr_ions$Ca[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  NH4N <- bpr_ions$`NH4-N`[
    bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2
  ]

  bpr_smoothed$K[i] <- mean(K, na.rm = TRUE)
  bpr_smoothed$`NO3-N`[i] <- mean(NO3N, na.rm = TRUE)
  bpr_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  bpr_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  bpr_smoothed$`NH4-N`[i] <- mean(NH4N, na.rm = TRUE)
}


### end of correct code

unique(bpr_ions$Sample_ID)

##test code
bpr_smoothed$Sample_ID[i] <- mean(K, na.rm = TRUE)
bpr_smoothed$Sample_ID[i] <- mean(NO3N, na.rm = TRUE)
bpr_smoothed$Sample_ID[i] <- mean(Mg, na.rm = TRUE)
bpr_smoothed$Sample_ID[i] <- mean(Ca, na.rm = TRUE)
bpr_smoothed$Sample_ID[i] <- mean(NH4N, na.rm = TRUE)

Sample_ID <- bpr_ions$Q1[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
Sample_ID <- bpr_ions$Q2[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
Sample_ID <- bpr_ions$Q3[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
Sample_ID <- bpr_ions$Q4[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
Sample_ID <- bpr_ions$MPR[
  bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2
]

##

glimpse(bpr_smoothed)

# Converting tibble to long
bpr_smoothed_long <- bpr_smoothed |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (Mg/L)"
  )

bpr_smoothed_long


# Plotting data
bpr_smoothed_long |>
  ggplot(
    mapping = aes(
      x = window_start,
      y = `Concentration (Mg/L)`,
      color = Ion
    )
  ) +
  geom_point() +
  geom_line() +
  labs(
    title = "Ion Concentration",
    x = "Year",
    y = "Concentration"
  ) +
  facet_wrap(~Ion, scales = "free", ncol = 1) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )


### Code for only 1 site all 5 ions

# Write the code to process and visualize the data
# 1988 - 1995

library(tidyverse)

bq1 <- read_csv("vm214final/data/QuebradaCuenca1-Bisley.csv")


glimpse(bq1)

#Best code for 1 site 5 ions
# Filtering to Sample Date, Site, and Ions only
bpr_1 <- bq1 |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03") |>
  select(Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`)

summary(bpr_1$Sample_Date)


#Creating empty tibble with apprpriate columns and widnows
bpr_smoothed <- tibble(
  window_start = seq(
    bpr_1$Sample_Date[1],
    bpr_1$Sample_Date[nrow(bpr_1)],
    by = "9 weeks"
  ),
  K = NA,
  `NO3-N` = NA,
  Mg = NA,
  Ca = NA,
  `NH4-N` = NA
)
bpr_smoothed


for (i in 1:nrow(bpr_smoothed)) {
  w1 <- bpr_smoothed$window_start[i]
  w2 <- w1 + 63

  site <- bpr_smoothed$Sample_ID[i]

  K <- bpr_1$K[
    bpr_1$Sample_Date >= w1 &
      bpr_1$Sample_Date < w2 &
      bpr_ions$Sample_ID == site
  ]
  NO3N <- bpr_1$`NO3-N`[
    bpr_1$Sample_Date >= w1 &
      bpr_1$Sample_Date < w2 &
      bpr_ions$Sample_ID == site
  ]
  Mg <- bpr_1$Mg[
    bpr_1$Sample_Date >= w1 &
      bpr_1$Sample_Date < w2 &
      bpr_ions$Sample_ID == site
  ]
  Ca <- bpr_1$Ca[
    bpr_1$Sample_Date >= w1 &
      bpr_1$Sample_Date < w2 &
      bpr_ions$Sample_ID == site
  ]
  NH4N <- bpr_1$`NH4-N`[
    bpr_1$Sample_Date >= w1 &
      bpr_1$Sample_Date < w2 &
      bpr_ions$Sample_ID == site
  ]

  bpr_smoothed$K[i] <- mean(K, na.rm = TRUE)
  bpr_smoothed$`NO3-N`[i] <- mean(NO3N, na.rm = TRUE)
  bpr_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  bpr_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  bpr_smoothed$`NH4-N`[i] <- mean(NH4N, na.rm = TRUE)
}


# Converting tibble to long
bpr_smoothed_long <- bpr_smoothed |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (mg/L)"
  )

bpr_smoothed_long


# Plotting data
bpr_smoothed_long |>
  ggplot(
    mapping = aes(
      x = window_start,
      y = `Concentration (mg/L)`,
      color = Ion
    )
  ) +
  geom_point() +
  geom_line() +
  labs(
    title = "Ion Concentration",
    x = "Year",
    y = "Concentration"
  ) +
  facet_wrap(~Ion, scales = "free", ncol = 1) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )


# Write the code to process and visualize the data
#(a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N
# 1988 - 1995

library(tidyverse)


BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP <- read_csv("data/RioMameyesPuenteRoto.csv")

glimpse(BQ1)
glimpse(BQ2)
glimpse(BQ3)
glimpse(RMP)

# Plotting only 1 varible form BQ1
BQ1 |>
  ggplot(
    mapping = aes(
      x = Sample_Date,
      y = K,
    )
  ) +
  geom_point() +
  labs(
    title = "K Concentration",
    x = "Year",
    y = "Concentration"
  )

# Joining Dataframes into 1
# Variables needed
# Sample_Date , K, `NO3-N`, Mg, Ca, `NH4-N`

BPR <- bind_rows(BQ1, BQ2, BQ3, RMP)


#Testing for correct Sample_Date
BPR_SD <- BPR |>
  filter(Sample_Date >= "1988-01-05" & Sample_Date < "1995-01-03")

glimpse(BPR_SD)

summary(BPR_SD$Sample_Date)

# Filtering to Sample Date, Site, and Ions only
bpr_ions <- BPR |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03") |>
  select(Sample_Date, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`)

summary(bpr_ions$Sample_Date)


#Creating empty tibble with appropriate columns and widnows
bpr_smoothed <- tibble(
  window_start = seq(
    bpr_ions$Sample_Date[1],
    bpr_ions$Sample_Date[nrow(bpr_ions)],
    by = "9 weeks"
  ),
  K = NA,
  `NO3-N` = NA,
  Mg = NA,
  Ca = NA,
  `NH4-N` = NA
)
bpr_smoothed


for (i in 1:nrow(bpr_smoothed)) {
  w <- bpr_smoothed$window_start[i]
  w2 <- w + 63

  K <- bpr_ions$K[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  NO3N <- bpr_ions$`NO3-N`[
    bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2
  ]
  Mg <- bpr_ions$Mg[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  Ca <- bpr_ions$Ca[bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2]
  NH4N <- bpr_ions$`NH4-N`[
    bpr_ions$Sample_Date >= w & bpr_ions$Sample_Date < w2
  ]

  bpr_smoothed$K[i] <- mean(K, na.rm = TRUE)
  bpr_smoothed$`NO3-N`[i] <- mean(NO3N, na.rm = TRUE)
  bpr_smoothed$Mg[i] <- mean(Mg, na.rm = TRUE)
  bpr_smoothed$Ca[i] <- mean(Ca, na.rm = TRUE)
  bpr_smoothed$`NH4-N`[i] <- mean(NH4N, na.rm = TRUE)
}

glimpse(bpr_smoothed)

# Converting tibble to long
bpr_smoothed_long <- bpr_smoothed |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (mg/L)"
  )

bpr_smoothed_long


# Plotting data
bpr_smoothed_long |>
  ggplot(
    mapping = aes(
      x = window_start,
      y = `Concentration (mg/L)`,
    )
  ) +
  geom_point() +
  labs(
    title = "Ion Concentration",
    x = "Year",
    y = "Concentration"
  )

# 5 sites on 1 graph, 1 line per site

library(tidyverse)
source("R/moving-average.R")

# Testing script with the function created in moving-average.R replacing the tibble and for loop code

BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP <- read_csv("data/RioMameyesPuenteRoto.csv")


bq1_result <- moving_average(BQ1)
bq2_result <- moving_average(BQ2)
bq3_result <- moving_average(BQ3)
rmp_result <- moving_average(RMP)

bq1_result$Sample_ID <- "BQ1"
bq2_result$Sample_ID <- "BQ2"
bq3_result$Sample_ID <- "BQ3"
rmp_result$Sample_ID <- "RMP"

BPR <- bind_rows(bq1_result, bq2_result, bq3_result, rmp_result)


bpr_ions <- BPR |>
  filter(window_start >= "1986-05-16" & window_start < "1995-01-03") |>
  select(window_start, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`)

bpr_long <- bpr_ions |>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (mg/L)"
  )

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
    y = "Concentration"
  ) +
  facet_wrap(~Ion, scales = "free", ncol = 1) +
  theme(
    plot.title = element_text(hjust = 0.5)
  )
