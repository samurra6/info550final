here::i_am("code/01maketable1.R")

heartdata <- read.csv(here::here("data/heart_2020_cleaned.csv"))

# Create variable labels
library(labelled)
library(gtsummary)
library(car)
library(kableExtra)

var_label(heartdata) <- list(
  HeartDisease = "Heart disease",
  AlcoholDrinking = "Alcohol drinking",
  PhysicalHealth = "Days with poor physical health in last month",
  MentalHealth = "Days with pool mental health in last month",
  DiffWalking = "Difficulty walking",
  AgeCategory = "Age category",
  PhysicalActivity = "Physical activity",
  GenHealth = "General health",
  SleepTime = "Average hours sleep per night",
  KidneyDisease = "Kidney disease",
  SkinCancer = "Skin cancer"
)

table1 <- heartdata |>
  tbl_summary(by = HeartDisease,
              statistic = where(is.numeric) ~ "{mean} ({sd})",
              type = all_dichotomous() ~ "categorical")|>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Heart disease status**") |>
  add_overall() |>
  bold_labels()

saveRDS(
  table1,
  file = here::here("output/table1.rds")
)
