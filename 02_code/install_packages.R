install.load.package <- function(x){
  if (!require(x, character.only = TRUE))
    install.packages(x, repos='http://cran.us.r-project.org')
  require(x, character.only = TRUE)
}
package_vec <- c("tidyr", "ggplot2", "viridis", "cowplot", "ggmap", "gimms", "rnaturalearth", "rnaturalearthdata", 
                 "mapview", "rosm", "ncdf4", "raster","rgdal", "tindync", "parallel","rgeos","sf","terra","libsecret-1-dev", "libunits-dev"
                 )
sapply(package_vec, install.load.package)

Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS = "true")
install.packages('https://cran.r-project.org/src/contrib/rosm_0.3.0.tar.gz', dependencies = TRUE, repos = NULL, type="source")
install.packages('https://cran.r-project.org/src/contrib/Archive/rgeos/rgeos_0.6-4.tar.gz', repos = NULL, type="source")
install.packages('https://cran.r-project.org/src/contrib/Archive/rgdal/rgdal_1.6-7.tar.gz', repos = NULL, type="source")

install.packages("renv")
renv::activate()
renv::restore()