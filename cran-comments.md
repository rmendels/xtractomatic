## Test environments
* local OS X install, R 3.3.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

New submission

Non-FOSS package license (file LICENSE)

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  xtracto (9:55, 11:5)
  xtractogon (11:53)
  xtractomatic (8:18)

Everythng above is correct.


** running examples for arch 'i386' ... [37s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    1.14   0.18   12.54
xtracto_3D 1.01   0.24   10.84
** running examples for arch 'x64' ... [38s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto    0.92   0.19   11.97
xtracto_3D 0.87   0.17   13.22

What this package does is download data forma remote server.  I have cut down the examples
significantly, but wanted to leave at least one running test.  I have gotten the times
down to close to 10s.  The times will vary based on the speed of the test machine
internet and how busy our server is, which is often busy.
