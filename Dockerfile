# Base image https://hub.docker.com/u/rocker/

#FROM rocker/r-ver
From rocker/geospatial



## create directories
RUN mkdir -p /01_data
RUN mkdir -p /02_code
RUN mkdir -p /03_output

## copy files
add /02_code/ /02_code/
# COPY /02_code/install_packages.R /02_code/install_packages.R
# COPY /02_code/myScript.R /02_code/myScript.R
# COPY /02_code/FUN_Plotting.R /02_code/FUN_Plotting.R
# COPY /02_code/Kriging.R /02_code/Kriging.R
# COPY /02_code/misc.R /02_code/misc.R


## install R-packages
CMD Rscript  /02_code/myScript.R
