## Test environments
* local OS X install, R 3.4.0
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs on OS X using devtools::check()
There was 1 note:

Non-standard file/directory found at top level:
  ‘cran-comments.md’

Which is this file. 


There was 4 NOTEs from win-builder-release:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'


Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)

Everythng above is correct.

Non-standard file/directory found at top level:
  'cran-comments.md'

This file

** running examples for arch 'i386' ... [32s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto  1.7   0.04   11.16
** running examples for arch 'x64' ... [34s] NOTE
Examples with CPU or elapsed time > 10s
        user system elapsed
xtracto 2.14   0.05   10.68

What this package does is download data from a remote server.  I have cut down the examples to be both smaller in extent and with lower-resolution datasets, but wanted to leave at least one running test that reflected what the scripts do.  The times I get at home  (not on our internal network) are all 7s or less.  I have gotten the times close to 10s on win-builder, also external to our system.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.

There were 1 NOTEs from win-builder-devel:

Non-standard file/directory found at top level:
  'cran-comments.md'

This file
  

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
