library(tidyverse)
source(moving_average.R)

BQ1<-read_csv("data/QuebradaCuenca1-Bisley.csv")
BQ2<-read_csv("data/QuebradaCuenca2-Bisley.csv")
BQ3<-read_csv("data/QuebradaCuenca3-Bisley.csv")
RMP<-read_csv("data/RioMameyesPuenteRoto.csv")

BPR<- bind_rows(BQ1, BQ2, BQ3, RMP)

bpr_ions<-BPR |> 
  filter(Sample_Date>="1986-05-16" & Sample_Date<"1995-01-03") |> 
  select(Sample_Date, K, `NO3-N`, Mg, Ca, `NH4-N`)

summary(bpr_ions$Sample_Date)


#  The input to this function should be a data frame containing stream chemistry data
moving_average <- function(ma) {

  # Initialize a tibble to contain the results
  result <- tibble(
    window_start = seq(bpr_ions$Sample_Date[1],
    bpr_ions$Sample_Date[nrow(bpr_ions)],
    by = "9 weeks"),
     K = NA,
    `NO3-N` = NA,
    Mg = NA,
    Ca = NA,
    `NH4-N` = NA
    # Fill in the rest of the ions
  )

  # Fill in the iterator and sequence
  for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
    w1 <- result$window_start[i]
    w2 <- w1 + 63

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    in_window <- (bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2)

    # Use indexing to pull out the ion concentrations that fall inside the window
    k_window <- bpr_ions$K[in_window]
    no3n_window <- bpr_ions$`NO3-N`[in_window]
    mg_window <- bpr_ions$Mg[in_window]
    ca_window <- bpr_ions$Ca[in_window]
    nh4n_window <- bpr_ions$`NH4-N`[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    result$K[i] <- mean(k_window, na.rm = TRUE)
    result$`NO3-N`[i] <- mean(no3n_window, na.rm = TRUE)
    result$Mg[i] <- mean(mg_window, na.rm = TRUE)
    result$Ca[i] <- mean(ca_window, na.rm = TRUE)
    result$`NH4-N`[i] <- mean(nh4n_window, na.rm = TRUE)


  }
}


glimpse(result)



# Converting tibble to long 
# Converting tibble to long 
result_long<-result|>
  pivot_longer(
    cols = c(K, `NO3-N`, Mg, Ca, `NH4-N`),
    names_to = "Ion",
    values_to = "Concentration (mg/L)"
  )

 result_long |> 
  ggplot(
    mapping = aes(
      x= window_start,
      y= `Concentration (mg/L)`,
      color = Ion
    )
  )+
  geom_point()+
  geom_line()+
  labs(
    title= "Ion Concentration",
    x= "Year",
    y= "Concentration"
  )+
  facet_wrap(~Ion, scales="free", ncol=1)+
   theme(
    plot.title = element_text(hjust = 0.5))