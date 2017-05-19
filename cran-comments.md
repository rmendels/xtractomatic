## Test environments
* local OS X install, R 3.4.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs or NOTES on OS X

There was 3 NOTEs from win-builder-release:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Days since last update: 1

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)

Everythng above is correct.

** running examples for arch 'i386' ... [39s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    2.89   0.28   11.96
xtracto_3D 1.33   0.00   13.98
** running examples for arch 'x64' ... [27s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto 3.35   0.17   10.58

What this package does is download data from a remote server.  I have cut down the examples to be both smaller in extent and with lower-resolution datasets, but wanted to leave at least one running test that reflected what the scripts do.  The times I get at home  (not on our internal network) are all 7s or less.  I have gotten the times close to 10s on win-builder, also external to our system.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.

There were 2 NOTEs from win-builder-devel:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

Days since last update: 1

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  
Everythng above is correct.

** running examples for arch 'i386' ... [28s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto  3.2   0.23   11.55
** running examples for arch 'x64' ... [27s] OK

See comment above about the timings.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
