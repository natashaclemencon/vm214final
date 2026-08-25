# Write the code to process and visualize the data
#(a) potassium, (b) nitrate-N, (c) magnesium, (d) calcium and (e) ammonium-N
# 1988 - 1995

library(tidyverse)

BQ1<-read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2<-read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3<-read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP<-read_csv("data/RioMameyesPuenteRoto.csv")

glimpse(BQ1)
glimpse(BQ2)
glimpse(BQ3)
glimpse(RMP)

# Plotting only 1 varible form BQ1
 BQ1 |> 
  ggplot(
    mapping = aes(
      x=Sample_Date,
      y=K,
    )
  )+
  geom_point()+
  labs(
    title= "K Concentration",
    x= "Year",
    y= "Concentration"
  )

# Joining Dataframes into 1
# Variables needed
# Sample_Date , K, `NO3-N`, Mg, Ca, `NH4-N`



BPR<- bind_rows(BQ1, BQ2, BQ3, RMP)


#Testing for correct Sample_Date
BPR_SD<-BPR |> 
  filter(Sample_Date>="1988-01-05" & Sample_Date<"1995-01-03")
  
glimpse(BPR_SD)

summary(BPR_SD$Sample_Date)

# Filtering to Sample Date, Site, and Ions only
bpr_ions<-BPR |> 
  filter(Sample_Date>="1986-05-16" & Sample_Date<"1995-01-03") |> 
  select(Sample_Date, Sample_ID, K, `NO3-N`, Mg, Ca, `NH4-N`)

summary(bpr_ions$Sample_Date)


#Creating empty tibble with apprpriate columns and widnows
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
  w1 <- bpr_smoothed$window_start[i]
  w2 <- w1 + 63

  K <- bpr_ions$K[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  NO3N <- bpr_ions$`NO3-N`[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  Mg <- bpr_ions$Mg[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  Ca <- bpr_ions$Ca[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]
  NH4N <- bpr_ions$`NH4-N`[bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2]

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
    values_to = "Concentration (Mg/L)"
  )

bpr_smoothed_long


# Plotting data
 bpr_smoothed_long |> 
  ggplot(
    mapping = aes(
      x=window_start,
      y=`Concentration (Mg/L)`,
    )
  )+
  geom_point()+
  labs(
    title= "Ion Concentration",
    x= "Year",
    y= "Concentration"
  )

