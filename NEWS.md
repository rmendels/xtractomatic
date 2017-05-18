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
