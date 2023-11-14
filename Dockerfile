# Base image https://hub.docker.com/u/rocker/

#FROM rocker/r-ver
From r-base



## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output
RUN mkdir =p /renv
## copy files
add /02_code/ /02_code/
add /01_data/ /01_data/

## install R-packages
CMD Rscript  /02_code/myScript.R
