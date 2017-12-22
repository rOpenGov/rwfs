## CHANGES IN VERSION 0.2.0 (2016-10-26)

### MAJOR CHANGES

+ Switch to using `sf` instead of `rgdal`.
+ Streaming directly from WFS supported properly.
+ `ogr2ogr` command-line conversion (or GDAL more broadly) is 
not required anymore for reading in data, even from 
WFS 2.0.0 source.
+ Internal function `convertOGR()` removed.

### NEW FEATURES

+ Class `WFSStreamingRequest` has a new method `getParameters()`
for quering the request object's current parameters.

### OTHER

+ Basic tests using `testthat` in place.
+ Use `download.file(methods = "internal", mode = "wb")` 
in `ẀFSClient::getRaster()`.