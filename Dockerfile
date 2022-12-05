FROM rocker/r-ubuntu
RUN apt-get update
RUN apt-get install -y pandoc
RUN apt-get install -y vim
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libssl-dev

RUN Rscript -e "install.packages('labelled')"
RUN Rscript -e "install.packages('gtsummary')"
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('knitr')"
RUN Rscript -e "install.packages('kableExtra')"
RUN Rscript -e "install.packages('tidyverse')"

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