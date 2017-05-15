## Test environments
* local OS X install, R 3.4.0
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

** running examples for arch 'i386' ... [81s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.37   0.16   10.17
xtracto_3D 1.01   0.11   59.14
** running examples for arch 'x64' ... [51s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.64   0.24   12.21
xtracto_3D 0.76   0.17   27.58

What this package does is download data from a remote server.  I have cut down the examples significantly from my previous attempt for this version, but wanted to leave at least one running test that reflected what the scripts do.  I have gotten the times close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.  The times I get from home are faster than what you get on the CRAN computers.

There were 3 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [48s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.87   0.13   10.63
xtracto_3D 1.06   0.07   23.79
** running examples for arch 'x64' ... [68s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.17   0.24   10.57
xtracto_3D 0.97   0.14   42.20

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
