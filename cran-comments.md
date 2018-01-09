## Test environments
* local OS X install, R 3.4.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs on OS X using devtools::check()


There was 1 NOTE from win-builder-release:

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)

Everythng above is correct.



There were 0 NOTEs from win-builder-devel:


## Comments

This release should fix the problems in the present CRAN builds.

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.

The actual submissions to CRAN are producing times for the xtracto example greater than 10s.  I am not getting that here nor on winbuilder.  The example is now as simple as it can be made.  The function extracts data along a track.  The track in the example is of length 2,  with the "radius" in each direction is the same as the dataset resolution,  so only one point is extracted at each time point in the track. 
