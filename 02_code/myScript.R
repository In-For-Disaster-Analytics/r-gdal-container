#rm(list=ls())
#gc() #free up memory and report the memory usage.
source("02_code/install_packages.R")

source("02_code/Kriging.R")
source("02_code/misc.R")
library(rosm)
library(gimms)
library(cowplot)
library(viridis)
library(ggplot2)
library(tidyr)
library(ncdf4)
library(raster)
library(rgdal)
library(tidync)
library(parallel)
library(rnaturalearth)
library(rgeos)
library(sf)
library(terra)



####### create functions
source("02_code/FUN_Plotting.R")  #Same as from the tutorial


##create directories
Dir.Base <- getwd() # identifying the current directory
Dir.Data <- file.path(Dir.Base, "Data") # folder path for data
Dir.Shapes <- file.path(Dir.Data, "Shapes") # folder path for shapefiles
Dir.Covariates <- file.path(Dir.Base, "Covariates")
dir.create(Dir.Covariates)
Dirs <- sapply(c(Dir.Data, Dir.Shapes), function(x) if (!dir.exists(x)) dir.create(x))
Dir.StateExt <- file.path(Dir.Data, "State_Extent")
dir.create(Dir.StateExt)
Dir.StatePipe <- file.path(Dir.Data, "State_Pipe")
Dir.GMTED2010 <- file.path(Dir.Covariates, "GMTED2010")
Dir.Exports <- file.path(Dir.Base, "Exports")
dir.create(Dir.StatePipe)
dir.create(Dir.GMTED2010)
dir.create(Dir.Exports)

####Define Shape file for the project
download.file("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_admin_1_states_provinces.zip",
              destfile = "highres.zip")
unzip("highres.zip")
Shape_shp <- readOGR("ne_10m_admin_1_states_provinces.shp")
#Shape_shp <- Shape_shp[Shape_shp$name_en %in% c("Texas"), ]
Extent <- extent(c(-97.5, -93.5, 28.5, 33.8)) # roughly the extent of Saxony
ggplot() +
  geom_polygon(data = Shape_shp, aes(x = long, y = lat, group = group), colour = "brown", fill = "black") +
  theme_bw() +
  labs(x = "Longitude", y = "Latitude")

####define extent
e <- extent(c(-97.5, -93.5, 28.5, 33.8)) # roughly the extent of Saxony
Extent <- as(e, 'SpatialPolygons')
crs(Extent) <- "+proj=longlat +datum=WGS84 +no_defs"
shapefile(Extent, 'Extent.shp', overwrite = T)
#bmaps.plot(bbox = Extent, type = "AerialWithLabels", quiet = TRUE, progress = "none")

Extent_crop <- crop(x = Shape_shp, 
                    y = Extent)
ggplot() +
  geom_polygon(data = Extent_crop, aes(x = long, y = lat, group = group), colour = "darkorange", fill = "lightgrey") +
  theme_bw() +
  labs(x = "Longitude", y = "Latitude")


##### Statrting Kriging ####################
### TAS

KrigStart1 <- Sys.time()
KrigStart1
##Historical Baseline-1
train_HIST_25km <- stack("01_data/test10yr/tas_day_CNRM-ESM2-1_historical_19701979.nc")
train_HIST_25km <- crop(train_HIST_25km,Extent_crop)
train_HIST_25km <- mask(train_HIST_25km, Extent_crop)

## Covariate Data
GMTED_DE_9km <- download_DEM(
  Train_ras = train_HIST_25km,
  Target_res = 0.008334,
  Shape = Extent_crop,
  Keep_Temporary = TRUE,
  Dir = Dir.Covariates
)

## Kriging
#Output_HIST_9km <- krigR(
#  Data = train_HIST_25km,
#  Covariates_coarse = GMTED_DE_9km[[1]], 
#  Covariates_fine = GMTED_DE_9km[[2]],  
#  Keep_Temporary = FALSE,
#  Cores = 10,
#  Dir = Dir.Exports,  
#  FileName = "CNRM-ESM2-1_hist_tas_1km_3.nc", 
#  nmax = 40
#)

##plotting Historical
#Plot_Krigs(Output_HIST_9km[[1]],
#           Shp = Extent_crop,
#           Dates = "CNRM-ESM2-1 Historical 1km", columns = 2)

KrigStop1 <- Sys.time()
KrigTime1 <- KrigStop1 - KrigStart1
KrigTime1