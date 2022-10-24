library(ggplot2)
library(tidyverse)

here::i_am("code/02makefigure.R")

heartdata <- read.csv(here::here("data/heart_2020_cleaned.csv"))

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

fig <- ggplot(heartdata, aes(x=HeartDisease, y=BMI, fill=HeartDisease, 
                             group=HeartDisease)) +
  geom_violin() +
  geom_boxplot(width=0.1, color="grey", alpha=0.2) +
  ggtitle("Figure 1: BMI Distribution by Heart Disease Status") +
  xlab('Heart Disease Status') +
  ylab ('BMI') +
  labs(fill='Heart Disease') +
  stat_summary(fun.BMI=mean, colour="darkred", geom="point", hape=18, size=3,show.legend=FALSE) +
  stat_summary(fun.BMI=mean, colour="black", geom="text", show.legend=FALSE, 
               vjust=-0.7, aes( label=round(..y.., digits=1)))

ggsave(
  here::here("output/figure.png"),
  plot = fig,
  device = "png"
)

