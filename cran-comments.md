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

** running examples for arch 'i386' ... [48s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.36   0.22   22.64
xtracto_3D 0.85   0.01   10.19
** running examples for arch 'x64' ... [43s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.39   0.35   15.46
xtracto_3D 0.81   0.00   11.60

What this package does is download data from a remote server.  I have cut down the examples even more significantly from my previous attempt for this version, but wanted to leave at least one running test that reflected what the scripts do.  I have gotten the times close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.  The times I get from home are faster than what you get on the CRAN computers, I get even the slowest at 6sec - 7sec.

There were 3 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [40s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.17   0.29   14.07
xtracto_3D 0.86   0.04   11.27
** running examples for arch 'x64' ... [46s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.40   0.30   15.63
xtractogon 1.34   0.03   11.61

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
