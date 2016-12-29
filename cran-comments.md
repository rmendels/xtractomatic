## Test environments
* local OS X install, R 3.3.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs or NOTES on OS X

There were 3 NOTEs:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Roy Mendelssohn <roy.mendelssohn@noaa.gov>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  ERD's (3:42, 9:29)
  ERDDAP (3:48, 9:35)

Everythng above is correct.


What this package does is download data from a remote server.  I have cut down the examples significantly, but wanted to leave at least one running test.  I have gotten the times down to close to 10s.  The times will vary based on the speed of the test machine internet and how busy our server is, which is often busy.

## Comments

As requested from the previous release,  the vignette now will make mutiple attempts to retrieve the data.
