library(tidyverse)
source("R/moving-average.R")



BQ1 <- read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2 <- read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3 <- read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP <- read_csv("data/RioMameyesPuenteRoto.csv")

BPR <- bind_rows(BQ1, BQ2, BQ3, RMP)

bpr_ions <- BPR |>
  filter(Sample_Date >= "1986-05-16" & Sample_Date < "1995-01-03") |>
  select(Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`)


#  The input to this function should be a data frame containing stream chemistry data
moving_average <- function(bpr_ions) 
  

# Converting tibble to long
  
result_long<-result|> 
  {
    
    result_long <- result |>
      pivot_longer(
        cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
        names_to = "Ion",
        values_to = "Concentration (mg/L)"
      )
  }
}

result_long |>
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
