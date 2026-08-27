library(tidyverse)

# Creating the function for moving average to insert into spaghetti script

#  The input to this function should be a data frame containing stream chemistry data
moving_average <- function(bpr_ions) {
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
  return(result)
}


## tested code

# The input to this function should be a data frame containing stream chemistry data

# Fill in the iterator and sequence
  #for (i in 1:nrow(result)) {
    # Create variables for the start and end of the current window
   # w1 <- result$window_start[i]
    #w2 <- w1 + 63

    # Create a logical vector, called "in_window", that says which samples are inside the window
    # Hint: you'll compare sample dates to the start and end of the window
    #in_window <- (bpr_ions$Sample_Date >= w1 & bpr_ions$Sample_Date < w2)

    # Use indexing to pull out the ion concentrations that fall inside the window
    #k_window <- bpr_ions$K[in_window]
    #no3n_window <- bpr_ions$`NO3-N`[in_window]
    #mg_window <- bpr_ions$Mg[in_window]
    #ca_window <- bpr_ions$Ca[in_window]
    #nh4n_window <- bpr_ions$`NH4-N`[in_window]
    # The line above gets potassium in the window. Get the rest of the ions too

    # Calculate the mean of each ion concentration and fill in the result
    #result$K[i] <- mean(k_window, na.rm = TRUE)
    #result$`NO3-N`[i] <- mean(no3n_window, na.rm = TRUE)
    #result$Mg[i] <- mean(mg_window, na.rm = TRUE)
    #result$Ca[i] <- mean(ca_window, na.rm = TRUE)
    #result$`NH4-N`[i] <- mean(nh4n_window, na.rm = TRUE)

    #return(result)
  #}

# end tested code