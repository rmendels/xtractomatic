# xtractomatic
xtractomatic R package for accessing environmental data

***Version 3.4.0 ****
- Changes to the order of the function arguments and required and option arguments in the functions.



- See vignette for lots of examples - https://https://rmendels.github.io/Usingxtractomatic_3_4.nb.html

`xtractomatic` is an <span style="color:blue">R</span> package developed to subset and extract satellite and other oceanographic related data from a remote server. The program can extract data for a moving point in time along a user-supplied set of longitude, latitude and time points; in a 3D bounding box; or within a polygon (through time).  The `xtractomatic` functions were originally developed for the marine biology tagging community, to match up environmental data available from satellites (sea-surface temperature, sea-surface chlorophyll, sea-surface height, sea-surface salinity, vector winds) to track data from various tagged animals or shiptracks (`xtracto`). The package has since been extended to include the routines that extract data a 3D bounding box (`xtracto_3D`) or within a polygon (`xtractogon`).  The `xtractomatic`  package accesses  data that are served through the <span style="color:blue">ERDDAP</span> (Environmental Research Division Data Access Program) server at the NOAA/SWFSC Environmental Research Division in Santa Cruz, California. The <span style="color:blue">ERDDAP</span> server can also be directly accessed at <http://coastwatch.pfeg.noaa.gov/erddap>. <span style="color:blue">ERDDAP</span> is a simple to use yet powerful web data service developed by Bob Simons.  


There are three main data extraction functions in the `xtractomatic` package: 

- `xtracto <- function(dtype, xpos, ypos, tpos = NA, xlen = 0., ylen = 0., verbose=FALSE)`

- `xtracto_3D <- function(dtype, xpos, ypos, tpos = NA, verbose=FALSE)`

- `xtractogon <- function(dtype, xpos, ypos, tpos = NA,  verbose = FALSE)`


There are two information functions in the `xtractomatic` package: 

- `searchData <- function(searchList= "varname:chl")  

- `getInfo <- function(dtype)`


The `dtype` parameter in the data extraction routines specifies a combination of which dataset on the <span style="color:red">ERDDAP</span> server to access, and as well as which parameter from that dataset. 

This version also includes the latest version of the `cmocean` colormaps,  designed by Kristen Thyng (see http://matplotlib.org/cmocean/ and https://github.com/matplotlib/cmocean).  These colormaps were initally developed for Python, and a version of the colormaps is used in the `oce` package by Dan Kelley and Clark Richards, but the colormaps used here are the version as of late 2017.  The colormaps are loaded automatically as `colors`, see `str(colors)`. Several of the examples make use of the `cmocean` colormaps.


`xtractomatic` uses the `httr`, `ncdf4`, `readr` and `sp` packages, and these packages must be installed first or `xtractomatic` will fail to install.

```{r install,eval=FALSE}
install.packages("httr", dependencies = TRUE)
install.packages("ncdf4",dependencies = TRUE) 
install.packages("readr", dependencies = TRUE)
install.packages("sp", dependencies = TRUE)
```


The `xtractomatic` package is available from <span style="color:blue">CRAN</span> and can be installed by:

```{r installCRAN,eval=FALSE}
install.packages("xtractomatic")
```

or the development version is available from [Github](https://github.com/rmendels/xtractomatic and can be installed from <span style="color:blue">Github</span>,

```{r installGit,eval=FALSE}
install.packages("devtools")
devtools::install_github("rmendels/xtractomatic")
```

If the other libraries  (`httr`, `ncdf4`, `readr` and `sp`) have been installed they will be found and do not need to be explicitly loaded.

The vignette uses the packages `DT`, `ggplot2`,  `lubridate`, `mapdata`, and  `reshape2`.


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


