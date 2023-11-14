# Installation on TACC

To install and run this container on tacc.

Run the following to pull the structure

```python
git clone https://github.com/In-For-Disaster-Analytics/r-gdal-container.git
```

Then Load the Apptainer software, and  RStats. 

``` 
module load tacc-apptainer

module spider Rstats 
module load intel/19.1.1  impi/19.0.9 Rstats

```
This should create a venv directory in your home. 
Move it into your repository 
```
cp -r venv/ r-gdal-container/
```
Finally changethe  directory into the workspace.
 ``` 
 cd r-gdal-container
```
You'll then pull the container from Docker

```
apptainer pull  wmobleytacc/r-gdal-container-tacc:0.2
```

Change any code you want in the 02_code/myscript.R . Put your data files in the 01_data and link it into the script. 


``` 
apptainer run r-gdal-container-tacc_0.2.sif
```


The libraries should load but are 02_code/install_packages.R and the krigr functions are in 02_code/Kriging.R and misc.R