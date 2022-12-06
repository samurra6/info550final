final.html: final.Rmd code/04render.R final.Rmd output/table1.rds output/figure.png output/table2.rds
	Rscript code/04render.R

output/table1.rds:code/01maketable1.R data/heart_2020_cleaned.csv
	Rscript code/01maketable1.R

output/figure.png: code/02makefigure.R data/heart_2020_cleaned.csv
	Rscript code/02makefigure.R
	
output/table2.rds:code/03maketable2.R data/heart_2020_cleaned.csv
	Rscript code/03maketable2.R
	
.PHONY: clean
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f final.html

dockerimage: Dockerfile code/01maketable1.R code/02makefigure.R code/03maketable2.R final.Rmd Makefile
	docker build -t fin .
	touch $@

pull image:
	docker pull samurra6/final550

dockermac:
	docker run -v "/$$(pwd)"/report:/project/report samurra6/final550

dockerpc:
	docker run -v "//$$(pwd)"/report:/project/report samurra6/final550