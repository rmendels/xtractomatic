## Test environments
* local OS X install, R 3.3.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs or NOTES on OS X

There was 1 NOTE from win-builder-release and one slow timing:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)

Everythng above is correct.

Examples with CPU or elapsed time > 5s
           user system elapsed
xtracto    1.53   0.38   10.22
xtracto_3D 1.04   0.06   15.29
xtractogon 0.87   0.04    6.08

What this package does is download data from a remote server.  I have cut down the examples significantly, but wanted to leave at least one running test.  I have gotten the times down to close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.

There were 3 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [45s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.25   0.18   12.12
xtracto_3D 1.15   0.11   18.31
** running examples for arch 'x64' ... [45s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.54   0.31   11.61
xtracto_3D 1.11   0.20   17.27

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
