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

** running examples for arch 'i386' ... [43s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.99   0.16   16.22
xtractogon 1.44   0.10   10.69
xtracto_3D 0.92   0.04   10.81
** running examples for arch 'x64' ... [41s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.91   0.19   11.94
xtracto_3D 0.71   0.00   17.25

What this package does is download data from a remote server.  I have cut down the examples significantly from my previous attempt for this version, but wanted to leave at least one running test that reflected what the scripts do.  I have gotten the times close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.  The times I get from home are faster than what you get on the CRAN computers.

There were 3 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [36s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.67   0.19   10.92
xtracto_3D 0.76   0.00   13.13
** running examples for arch 'x64' ... [37s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    3.05   0.22   10.31
xtractogon 1.12   0.01   10.14
xtracto_3D 0.65   0.00   11.03

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
