## Test environments
* local OS X install, R 3.3.1
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There were 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)
  xtractomatic (8:18)

Everythng above is correct.


** running examples for arch 'i386' ... [34s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto_3D 1.24   0.14   10.44
** running examples for arch 'x64' ... [34s] NOTE
Examples with CPU or elapsed time > 10s
           user system elapsed
xtracto_3D 0.76   0.14   12.68

What this package does is download data from a remote server.  I have cut down the examples significantly, but wanted to leave at least one running test.  I have gotten the times down to close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.

## Comments

Added URL for ERDDAP service in DESCRIPTION file as requested.
Moved disclaimer to LICENSE.note as requested.
Changed function names to include () in DESCRIPTION (xtracto()) as requested
