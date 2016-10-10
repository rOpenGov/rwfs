rwfs
====

[![Build Status](https://api.travis-ci.org/rOpenGov/rwfs.png)](https://travis-ci.org/rOpenGov/rwfs)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rOpenGov/rwfs?branch=master&svg=true)](https://ci.appveyor.com/project/rOpenGov/rwfs)
[![Stories in Ready](https://badge.waffle.io/ropengov/rwfs.png?label=Ready)](http://waffle.io/ropengov/rwfs)

WFS client for R

+ Maintainers: [Jussi Jousimo](http://www.github.com/statguy/)
+ License: FreeBSD

### Overview

This R package provides a client to access a [Web Feature Service](http://www.opengeospatial.org/standards/wfs) (WFS).

### Usage

#### Installation

The `rwfs` package requires `R6`, `rgal` and `raster` (optional) packages. Please refer to the
[gisfin tutorial](https://github.com/rOpenGov/gisfin/blob/master/vignettes/gisfin_tutorial.md) for installation instructions of `rgdal`.
The package can be installed from github using `devtools`
```
install.packages("devtools")
library("devtools")
install_github("ropengov/gisfin")
```
and loaded with
```
library(rwfs)
```

#### Request and client classes

The package consists of request and client classes which are of type
[R6](http://cran.r-project.org/web/packages/R6/vignettes/Introduction.html).
The request classes are used to construct a reference to a data source and provide access methods to the data.
The client classes dispatch a request to obtain and possibly manipulate the data.

The request classes currently implemented are

* `WFSStreamingRequest` for streaming data directly from a WFS,
* `WFSCachingRequest` for downloading data from a WFS and caching it to disk and
* `GMLFile` for reading data from a [GML](http://en.wikipedia.org/wiki/Geography_Markup_Language) file.

All request classes are abstract with the exception of `GMLFile` meaning that the user of `rwfs` must provide a subclass
for each relevant class and implement abstract methods in the classes. The user may provide additional methods for
accessing the data for convenience.

Due to limited support for WFS 2.x in the `rgdal` package, which the `rwfs` package depends on, data in WFS 2.x is
accessible only via downloading the data first and thus no streaming can be used (at least in some services).

The following client classes are currently implemented

* `WFSStreamingClient` for streaming requests and
* `WFSCachingClient` for downloading and caching requests and for local file access requests.

The client classes are available to be used directly. However, additional methods for manipulating data for user convenience
can be provided by inheriting the classes.

In the following sections, we illustrate the use of the `rwfs` package by following two examples taken from the packages
[gisfin](https://github.com/rOpenGov/gisfin) and [fmi](https://github.com/rOpenGov/fmi).

#### Inheritance of request classes

For streaming, the `WFSStreamingRequest` abstract class is required to be inherited to a subclass that implements the abstract
method `getDataSource()`, which provides a data access reference. For example
(taken from [gisfin](https://github.com/rOpenGov/gisfin/blob/master/R/GeoStatFi.R)), the following class provides a URL
to access data with the private method `getURL()`, which is called from `getDataSource()`:
```
GeoStatFiWFSRequest <- R6::R6Class(
  "GeoStatFiWFSRequest",
  inherit = rwfs::WFSStreamingRequest,
  private = list(
    getURL = function() {
      url <- paste0("http://geo.stat.fi/geoserver/", private$getPathString(), "/wfs?", private$getParametersString())
      return(url)
    }
  ),
  public = list(
    getDataSource = function() private$getURL(),
    
    getGeoStatFiLayers = function(path) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      return(self$setPath(path)$getCapabilities())
    },

    getGeoStatFiLayer = function(path, layer) {
      if (missing(path))
        stop("Required argument 'path' missing.")      
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      return(self$setPath(path)$getFeature(typeName=layer))
    },
    
    getPopulationLayers = function() self$getGeoStatFiLayers("vaestoruutu"),
    getPopulation = function(layer) self$getGeoStatFiLayer("vaestoruutu", layer),
    getProductionAndIndustrialFacilitiesLayers = function() self$getGeoStatFiLayers("ttlaitokset/ttlaitokset:toimipaikat"),
    getProductionAndIndustrialFacilities = function(layer="ttlaitokset:toimipaikat") self$getGeoStatFiLayer("ttlaitokset/ttlaitokset:toimipaikat", layer),
    getEducationalInstitutionsLayers = function() self$getGeoStatFiLayers("oppilaitokset/oppilaitokset:oppilaitokset"),
    getEducationalInstitutions = function(layer="oppilaitokset:oppilaitokset") self$getGeoStatFiLayer("oppilaitokset/oppilaitokset:oppilaitokset", layer),
    getRoadAccidentsLayers = function() self$getGeoStatFiLayers("tieliikenne"),
    getRoadAccidents = function(layer) self$getGeoStatFiLayer("tieliikenne", layer),
    getPostalCodeAreaLayers = function() self$getGeoStatFiLayers("postialue"),
    getPostalCodeArea = function(layer) self$getGeoStatFiLayer("postialue", layer)
  )
)
```
The method `getGeoStatFiLayers(path)` lists available layers by setting `path`, which refers to the data set behind `path` in the service,
and the method `getGeoStatFiLayer(path, layers)` which obtains the `layer` layer from the `path` data set. The rest of the methods are for
convenience purpose for the user that cover the available data sets in the service.

Similar to `WFSStreamingRequest`, `WFSCachingRequest` must implement the `getURL` abstract method
(example taken from [fmi](https://github.com/rOpenGov/fmi/blob/master/R/FMIWFSRequest.R)):
```
FMIWFSRequest <- R6::R6Class(
  "FMIWFSRequest",
  inherit = rwfs::WFSCachingRequest,
  private = list(
    apiKey = NA,
    
    getURL = function() {
      url <- paste0("http://data.fmi.fi/fmi-apikey/", private$apiKey, "/wfs?", private$getParametersString())
      return(url)
    }
  ),
  public = list(
    initialize = function(apiKey) {
      if (missing(apiKey))
        stop("Must specify the 'apiKey' parameter.")
      private$apiKey <- apiKey
    }    
  )
)
```
Here the class provides also a mechnism for storing an API key, which is required to access the service.

#### Inheritance of client classes

Continuing with the example from [gisfin](https://github.com/rOpenGov/gisfin/blob/master/R/GeoStatFi.R), there
is no need to inherit `WFSStreamingClient`. However, for consistency the package provides the class
`GeoStatFiWFSClient` inheriting `WFSStreamingClient`, which is exactly the same class but with a different name.

The `FMIWFSClient` class inheriting `WFSCachingClient` in the [fmi](https://github.com/rOpenGov/fmi/blob/master/R/FMIWFSClient.R)
example, sets the service access parameters and returns data after formatting it. For example, the `getMonthlyWeatherRaster`
calls the `setParameters()` method in the request object and the `getRaster()` in the superclass to obtain a `raster` object.
```
FMIWFSClient <- R6::R6Class(
  "FMIWFSClient",
  inherit = rwfs::WFSCachingClient,
  private = list(
    processParameters = function(startDateTime=NULL, endDateTime=NULL, bbox=NULL, fmisid=NULL) {
      [...]
    },
    
    getRasterURL = function(parameters) {
      [...]
    }
  ),
  public = list(
    getDailyWeather = function(variables=c("rrday","snow","tday","tmin","tmax"), startDateTime, endDateTime, bbox=NULL, fmisid=NULL) {      
      [...]
    },
    
    getMonthlyWeatherRaster = function(startDateTime, endDateTime) {
      if (inherits(private$request, "FMIWFSRequest")) {
        if (missing(startDateTime) | missing(endDateTime))
          stop("Arguments 'startDateTime' and 'endDateTime' must be provided.")
        
        p <- private$processParameters(startDateTime=startDateTime, endDateTime=endDateTime)
        private$request$setParameters(request="getFeature",
                                      storedquery_id="fmi::observations::weather::monthly::grid",
                                      starttime=p$startDateTime,
                                      endtime=p$endDateTime)
      }
      
      response <- self$getRaster(parameters=list(splitListFields=TRUE))
      if (is.character(response)) return(character())
      NAvalue(response) <- 9999
      names(response) <- getRasterLayerNames(startDateTime=startDateTime,
                                             endDateTime=endDateTime,
                                             by="month",
                                             variables=c("MeanTemperature", "Precipitation"))
      return(response)
    }
  )
)
```
The `getMonthlyWeatherRaster()` method first checks that request object has been given and it is of the type
`FMIWFSRequest`. The method also does some data manipulation such as setting layer names for the `raster` object.

#### Accessing WFS

Once we have defined appropriate subclasses, we can build a request object and access WFS to obtain
data with a client object. For examples, please look at the vignettes in the
[gisfin](https://github.com/rOpenGov/gisfin/blob/master/vignettes/gisfin_tutorial.md) and in the
[fmi](https://github.com/rOpenGov/fmi/blob/master/vignettes/fmi_tutorial.md) packages.

#### File access

An example to access a local GML file:
```
library(rwfs)
fileName <- tempfile()
download.file("http://geo.stat.fi/geoserver/vaestoalue/wfs?service=WFS&version=1.0.0&request=GetFeature&typeName=vaestoalue:suuralue_vaki2014", fileName)
request <- rwfs::GMLFile$new(fileName)
client <- rwfs::WFSCachingClient$new(request)
layer <- client$getLayer("suuralue_vaki2014")
print(layer@data)
plot(layer)
unlink(fileName)
```

### Contact

  You are welcome to:

  * [submit suggestions and bug-reports](https://github.com/ropengov/rwfs/issues)
  * [submit a pull-request](https://github.com/rOpenGov/rwfs/pulls)
  * compose a friendly e-mail to: [jvj@iki.fi](mailto:jvj@iki.fi)
  * join IRC at !louhos@IRCnet (Finland) and ropengov@Freenode (international)
  * follow us in social media: Louhos (Finland); rOpenGov (international)

### Acknowledgements

  Roger Bivand for helping with the rgdal package.
  