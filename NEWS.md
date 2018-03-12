# xtractomatic 3.4.2
Proper handling of temporary files

# xtractomatic 3.4.1
Changed so URL sends ISO time,  not udunits time.


# xtractomatic 3.4.0

- Major refactoring of code,  order of function arguments and defaults has changed.
- searchData() no longer uses a list of list, instead it uses a simple list where the each “searchType” and “searchString” are set off by a colon as in “searchType:searchString”.
- Added cmocean colormaps.
- Added check if dataset is available.
- Better checks if download fails at any point.
- If xtracto() call fails part-way through,  results to that point returned.
- Changed some examples for faster execution.

# xtractomatic 3.3.2

added back in ncdcOisst2Agg dataset

# xtractomatic 3.3.1

Changed examples to run faster on CRAN machines.

# xtractomatic 3.3.0

* Changed the organization of the underlying erddapStruct that contains dataset information, removed outdated datasets.
* Changed searchData() to use a simple list with text strings of the form searchType:searchText
* Corrected searchData() for case where there are no matches
* searchData() and getInfo() now return results using View().
* Modified encoding of urls to work with newer versions of Apache Tomcat.




# xtractomatic 3.2.0

* Changed to using https instead of http.
* Examples dataset changed as previous one is no longer available
* Vignette now makes multiple tries to get the data
* getFileCoords() now makes multiple tries to get the dataset coordinate values
