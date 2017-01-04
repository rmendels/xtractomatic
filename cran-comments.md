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

** running examples for arch 'i386' ... [36s] OK
Examples with CPU or elapsed time > 5s
           user system elapsed
xtracto    1.74   0.24   10.88
xtractogon 1.19   0.00    7.16
xtracto_3D 0.69   0.03    8.73
searchData 0.02   0.00    5.96
** running examples for arch 'x64' ... [33s] OK
Examples with CPU or elapsed time > 5s
           user system elapsed
xtracto    1.66   0.28   10.87
xtractogon 1.01   0.02    6.88
xtracto_3D 0.64   0.02    7.47
searchData 0.04   0.00    5.43

What this package does is download data from a remote server.  I have cut down the examples significantly from my previous attempt for this version, but wanted to leave at least one running test that reflected what the scripts do.  I have gotten the times close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.  The times I get from home are faster than what you get on the CRAN computers.

There were 3 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [30s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto 2.87    0.2   10.17
** running examples for arch 'x64' ... [30s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto  3.2   0.25   10.98

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
