# vm214final
# Recreating the 9 Week Moving Average of Stream Ion Concentrations in Bisley, Puerto Rico
This repository contains all the code useed to recreate the analysis figure 3 of the 9 week moving average from Schaefer et al. (2000) study of ion concentrations in Bisley, Puerto Rico streams, before and after Hurricane Hugo. 

# Data
The data and code for this analysis is organized within three folders

- data folder containg the four raw data files downloaded from the EDI data portal: "QuebradaCuenca1-Bisley.csv",     "QuebradaCuenca2-Bisley.csv", "QuebradaCuenca3-Bisley.csv", "RioMameyesPuenteRoto.csv"
- scratch folder containing code drafts
- final folder containg the final version of the code. 

# Data Cleaning

In this repository is the data and code to process and visualize the data for potassium, nitrate, magnesium, calcium, and ammonium from four sample sites between 1988 and 1995. These codes are used to: 

- Join the four dataframes.
- Clean the data to only include the columns for Sample Date, Sample Site, and the five ions of interest.
- Creating a tibble with the columns for 9-week window and ions of interest.
- Calculating the 9-week moving average and inserting into the tibble.
- Mutating the tibble into tidy form for visualization
- Creating the graph to visualize the 9-week moving average for the four sample sites.

# Data Access

The code and data is housed on a workbench server. The tidyverse package needs to be added in order to run the analysis code.

# References
McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” Environmental Data Initiative. https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458.

Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. https://doi.org/10.1017/s0266467400001358.
