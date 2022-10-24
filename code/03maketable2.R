here::i_am("code/03maketable2.R")

heartdata <- read.csv(here::here("data/heart_2020_cleaned.csv"))

library(tidyverse)

heartdataclean <- heartdata |>
  mutate(HeartDisease = ifelse(HeartDisease == "No",0,1)) |>
  mutate(Smoking = ifelse(Smoking == "No",0,1)) |>
  mutate(AlcoholDrinking = ifelse(AlcoholDrinking == "No",0,1)) |>
  mutate(PhysicalHealth = ifelse(PhysicalHealth == "No",0,1)) |>
  mutate(MentalHealth = ifelse(MentalHealth == "No",0,1)) |>
  mutate(DiffWalking = ifelse(DiffWalking == "No",0,1)) |>
  mutate(PhysicalActivity = ifelse(PhysicalActivity == "No",0,1)) |>
  mutate(Asthma = ifelse(Asthma == "No",0,1)) |>
  mutate(KidneyDisease = ifelse(KidneyDisease == "No",0,1)) |>
  mutate(SkinCancer = ifelse(SkinCancer == "No",0,1))

library(gtsummary)

mod <- glm(HeartDisease ~ BMI + Sex + Race + Smoking + Asthma, data = heartdataclean, family=binomial)

table2 <- tbl_regression(mod) |>
  add_global_p() |>
  bold_labels()

saveRDS(
  table2,
  file = here::here("output/table2.rds")
)

table2
