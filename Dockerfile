FROM rocker/r-ubuntu
RUN apt-get update
RUN apt-get install -y pandoc \
  vim \
  libcurl4-openssl-dev \
  libxml2-dev \
  libfontconfig1-dev \
  libssl-dev \
  file \
  cmake

RUN Rscript -e "install.packages('labelled')"
RUN Rscript -e "install.packages('gtsummary')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('kableExtra')"
RUN Rscript -e "install.packages('tidyverse')"
RUN Rscript -e "install.packages('car')"

run mkdir /project
workdir /project
run mkdir code
run mkdir output
run mkdir data
run mkdir report

copy Makefile .
copy final.Rmd .
copy README.md .
copy data/heart_2020_cleaned.csv data
copy code/01maketable1.R code
copy code/02makefigure.R code
copy code/03maketable2.R code
copy code/04render.R code

cmd make && mv final.html report