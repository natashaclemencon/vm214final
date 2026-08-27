## README.md
- I love the detail you have for where the data comes from/cleaning process. For the first "Data" section, you start to talk about the organization of your repo files, maybe you want to change the title of this section to something like "Repo Structure" and you could expand your description of the repo structure to include what the output, paper, and docs files hold

## File organization
- Looks like you have all the raw data in the data/ folder, I think you can delete the extra RioMameyesPuenteRoto.csv from your repo

- you can add headers to the self-assessment.md file by using hashes (#)

- You may want to move the scatterplot png out of your paper/ file

## R/moving-average.R
- In moving-average.R line 26, you could replace the w1 + 63 with w2 <- w1 + "9 weeks" to improve clarity of the time period
- I like the names you chose for your variables in the function, they are descriptive and succinct

The figure looks great and in the right timeframe. You could consider removing geom_point() from the code to look closer to the original image

## Outputs
- Instead of cleaning your data in outputs/9week-moving-average.R, you can take that file out of outputs and into the main repo folder as 1_clean_data.R Then you can use write_csv(clean_dataframe, "outputs/title_of_clean_dataframe.csv") to make a csv file in outputs/