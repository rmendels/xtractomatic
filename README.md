# xtractomatic
xtractomatic R package for accessing environmental data

***Version 3.4.0 Available for Testing ****
- Changes to the order of the function arguments and required and option arguments in the functions.

- Simple plot routines that mostly just need the result from an extract.

- See vignette for the development versions for lots of examples -https://rmendels.github.io/Usingxtractomatic_Dev.nb.html

`xtractomatic` is an <span style="color:blue">R</span> package developed to subset and extract satellite and other oceanographic related data from a remote server. The program can extract data for a moving point in time along a user-supplied set of longitude, latitude and time points; in a 3D bounding box; or within a polygon (through time).  The `xtractomatic` functions were originally developed for the marine biology tagging community, to match up environmental data available from satellites (sea-surface temperature, sea-surface chlorophyll, sea-surface height, sea-surface salinity, vector winds) to track data from various tagged animals or shiptracks (`xtracto`). The package has since been extended to include the routines that extract data a 3D bounding box (`xtracto_3D`) or within a polygon (`xtractogon`).  The `xtractomatic`  package accesses  data that are served through the <span style="color:blue">ERDDAP</span> (Environmental Research Division Data Access Program) server at the NOAA/SWFSC Environmental Research Division in Santa Cruz, California. The <span style="color:blue">ERDDAP</span> server can also be directly accessed at <http://coastwatch.pfeg.noaa.gov/erddap>. <span style="color:blue">ERDDAP</span> is a simple to use yet powerful web data service developed by Bob Simons.  


There are three main data extraction functions in the `xtractomatic` package: 

- `xtracto <- function(dtype, xpos, ypos, tpos = NA, xlen = 0., ylen = 0., verbose=FALSE)`

- `xtracto_3D <- function(dtype, xpos, ypos, tpos = NA, verbose=FALSE)`

- `xtractogon <- function(dtype, xpos, ypos, tpos = NA,  verbose = FALSE)`


There are two information functions in the `xtractomatic` package: 

- `searchData <- function(searchList= "varname:chl")  

- `getInfo <- function(dtype)`

There are now two plotting functions that make use of the <span style="color:red">R</span> package `plotdap`:

- `plotTrack <- function(resp, xcoord, ycoord, plotColor = 'viridis', name = NA, myFunc = NA, shape = 20, size = .5)`

- `plotBBox <- function(resp, plotColor = 'viridis', time = NA, animate = FALSE, name = NA, myFunc = NA, maxpixels = 10000)`

The `dtype` parameter in the data extraction routines specifies a combination of which dataset on the <span style="color:red">ERDDAP</span> server to access, and as well as which parameter from that dataset. The first sections demonstrate how to use these functions in realistic settings. The [Selecting a dataset](#dataset) section shows how to find the `dtype` or other parameters of interest from the available datasets.

`xtractomatic` uses the `httr`, `ncdf4` and `sp` packages , and these packages (and the packages imported by these packages) must be installed first or `xtractomatic` will fail to install.   

```{r install,eval=FALSE}
install.packages("httr", dependencies = TRUE)
install.packages("ncdf4") 
install.packages("sp")
```

This development version of `xtractomatic` is available from https://github.com/rmendels/xtractomatic and can be installed from <span style="color:red">Github</span>,

```{r installGit,eval=FALSE}
install.packages("devtools")
devtools::install_github("rmendels/xtractomatic")
```

In order to use the plot routines,  you must have the package `plotdap` installed, as well as all of its dependencies,  most importantly `rerddap` and `sf` (but note these are only needed if you are using the plotting routines.   The latter two can be installed from CRAN:

```{r ,eval=FALSE}
install.packages("rerddap", dependencies = TRUE)
install.packages("sf", dependencies = TRUE)
```

The `plotdap` package can be installed from <span style="color:red">Github</span>:

```{r ,eval=FALSE}
install.packages("devtools")
devtools::install_github('ropensci/plotdap', dependencies = TRUE)
```


The vignette provides a lot of examples of using `xtractomatic`, and it is not built by default by `devtools`.

To install and build the Vignette, do:

```{r install,eval=FALSE}
install.packages("devtools")
devtools::install_github("rmendels/xtractomatic", build_vignettes = TRUE)
```

The Vignette examples require the following packages and will not build if they are not installed:

- `ggplot2`
- `ggfortify` 
- `lubridate`
- `mapdata`
- `RColorBrewer`
- `reshape2`
- `xts`


Note however, that the Vignette generates graphics by doing a large number of downloads using `xtractomatic`, and the build may fail if the server is busy or your internet line is slow.


# Required legalese

“The United States Department of Commerce (DOC) GitHub project code is provided
on an ‘as is’ basis and the user assumes responsibility for its use.
DOC has relinquished control of the information and no longer has responsibility
to protect the integrity, confidentiality, or availability of the information.
Any claims against the Department of Commerce stemming from the use of its
GitHub project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their endorsement,
recommendation or favoring by the Department of Commerce. The Department of
Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used
in any manner to imply endorsement of any commercial product or activity by DOC
or the United States Government.”


