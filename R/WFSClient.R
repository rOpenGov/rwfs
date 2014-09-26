# This file is a part of the rwfs package (http://github.com/rOpenGov/rwfs)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2014 Jussi Jousimo
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' @include WFSRequest.R

#' @title WFS client abstract reference class
#' 
#' @aliases getRasterURL importRaster
#'
#' @import methods
#' @import sp
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSClient
#' @export WFSClient
WFSClient <- setRefClass(
  "WFSClient",
  methods = list(
    .private.listLayers = function(dataSource) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      
      layers <- try(rgdal::ogrListLayers(dsn=dataSource)) 
      if (inherits(layers, "try-error")) {
        if (length(grep("Cannot open data source", layers)) == 1) {
          # GDAL < 1.11.0 returns "Cannot open data source" for connection problems and zero layer responses
          # GDAL >= 1.11.0 returns no layers for zero layer responses
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      return(layers)
    },
    
    .private.getLayer = function(dataSource, layer, crs=NULL, swapAxisOrder=FALSE) {
      if (missing(dataSource))
        stop("Required argument 'dataSource' missing.")
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      if (!inherits(dataSource, "character"))
        stop("Argument 'dataSource' must be a descendant of class 'character'.")

      #response <- try(rgdal::readOGR(dsn=dataSource, layer=layer, p4s=crs, swapAxisOrder=swapAxisOrder, stringsAsFactors=FALSE)) # Works only in rgdal >= 0.9
      response <- try(rgdal::readOGR(dsn=dataSource, layer=layer, p4s=crs, stringsAsFactors=FALSE))
      if (inherits(response, "try-error")) {
        if (length(grep("Cannot open data source", response)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      # Hack and will be removed once rgdal 0.9 becomes available in CRAN
      if (swapAxisOrder) {
        xy <- sp::coordinates(response)
        response@coords <- xy[,2:1]
        response@bbox <- response@bbox[2:1,]
        rownames(response@bbox) <- rownames(response@bbox)[2:1]
      }
      
      return(response)
    },
    
    listLayers = function(request) {
      "Lists data layers from a WFS query."
      stop("Unimplemented method.")
    },
    
    getLayer = function(request, layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      "Returns layer data from a WFS query."
      stop("Unimplemented method.")
    },

    getRasterURL = function(request, parameters) {
      "Returns raster URL from a WFS query response."
      stop("Unimplemented method.")
    },
    
    importRaster = function(destFile) {
      "Imports raster from downloaded file."
      raster <- raster::brick(destFile)
      return(raster)
    },
    
    getRaster = function(request, parameters) {
      "Returns raster from WFS query."
      rasterURL <- getRasterURL(request=request, parameters=parameters)
      if (length(rasterURL) == 0) return(character())
      
      destFile <- tempfile()
      success <- download.file(rasterURL, destfile=destFile)
      if (success != 0) {
        warning("Failed to download raster file.")
        return(character())
      }
      
      raster <- importRaster(destFile)
      return(raster)
    }
  )
)

#' @title Streams response from a WFS
#' 
#' @description Dispatches WFS request and parses response from the stream. Provides a caching mechanism
#' for the same subsequent queries. The absract method \code{\link{getRasterURL}} should be overloaded for
#' raster queries and possibly \code{\link{importRaster}} as well.
#'
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSFileClient}}
#'
#' @import methods
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSStreamClient
#' @export WFSStreamClient
WFSStreamClient <- setRefClass(
  "WFSStreamClient",
  contains = "WFSClient",
  methods = list(
    listLayers = function(request) {
      if (missing(request))
        stop("Required argument 'request' missing.")
      if (!inherits(request, "WFSRequest"))
        stop("Argument 'request' must be a descendant of class 'WFSRequest'.")
      
      dataSourceURL <- request$getStreamURL()
      layers <- .private.listLayers(dataSource=dataSourceURL)
      return(layers)
    },
    
    getLayer = function(request, layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      if (missing(request))
        stop("Required argument 'request' missing.")
      if (missing(layer))
        stop("Required argument 'layer' missing.")
      if (!inherits(request, "WFSRequest"))
        stop("Argument 'request' must be a descendant of class 'WFSRequest'.")
      
      dataSourceURL <- request$getStreamURL()
      response <- .private.getLayer(dataSource=dataSourceURL, layer=layer, crs=crs, swapAxisOrder=swapAxisOrder)
      return(response)
    }
  )
)

#' @title Reads response from a file instead of a WFS service directly
#' 
#' @description Dispatches WFS request, saves response to a file and parses the file.
#' The absract method \code{\link{getRasterURL}} should be overloaded for raster queries and possibly
#' \code{\link{importRaster}} as well.
#'
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSStreamClient}}
#'
#' @import methods
#' @import rgdal
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSFileClient
#' @export WFSFileClient
WFSFileClient <- setRefClass(
  "WFSFileClient",
  contains = "WFSClient",
  fields = list(
    cachedDataSourceURL = "character",
    cachedResponseFile = "character"
  ),
  methods = list(
    initialize = function(...) {
      callSuper(...)
      cachedDataSourceURL <<- ""
      cachedResponseFile <<- ""
    },
    
    saveGMLFile = function(destFile) {
      "Saves cached response to a file in GML format."
      if (missing(destFile))
        stop("Required argument 'destFile' missing.")
      if (length(cachedResponseFile) == 0 || !file.exists(cachedResponseFile))
        stop("Response file missing. No query has been made?")
      file.copy(cachedResponseFile, destFile)
      return(invisible(.self))
    },
    
    loadGMLFile = function(fromFile) {
      "Loads saved GML file into the object for parsing."
      if (missing(fromFile))
        stop("Required argument 'fromFile' missing.")
      if (!file.exists(fromFile))
        stop("File does not exist.")
      cachedResponseFile <<- fromFile
      return(invisible(.self))
    },
    
    cacheResponse = function(dataSourceURL) {
      if (missing(dataSourceURL))
        stop("Required argument 'dataSourceURL' missing.")
      if (!inherits(dataSourceURL, "character"))
        stop("Argument 'dataSourceURL' must be a descendant of class 'dataSourceURL'.")
      
      if (cachedDataSourceURL != dataSourceURL) {
        cachedDataSourceURL <<- dataSourceURL
        cachedResponseFile <<- tempfile()
        success <- download.file(dataSourceURL, cachedResponseFile, "internal")
        if (success != 0) {
          warning("Query failed.")
          return(character(0))
        }
      }
      return(invisible(.self))
    },
    
    convert = function(sourceFile, layer, parameters) {
      destFile <- tempfile()
      cmd <- paste("ogr2ogr -f GML", parameters, destFile, cachedResponseFile, layer)
      message(cmd)
      errorCode <- system(cmd)
      if (errorCode != 0) {
        stop("Conversion failed.")
      }
      unlink(cachedResponseFile)
      cachedResponseFile <<- destFile
      return(invisible(.self))
    },
    
    listLayers = function(request) {
      if (!missing(request)) {
        success <- cacheResponse(dataSource=request$getURL())
        if (is.character(success)) return(character(0))
      }
      else {
        if (cachedResponseFile == "")
          stop("Specify 'request' argument or load file with 'loadGLMFile'.")
      }
      layers <- .private.listLayers(dataSource=cachedResponseFile)
      return(layers)
    },
    
    getLayer = function(request, layer, crs=NULL, swapAxisOrder=FALSE, parameters) {
      if (!missing(request)) {
        success <- cacheResponse(dataSourceURL=request$getURL())
        if (is.character(success)) return(character(0))
      }
      else {
        if (cachedResponseFile == "")
          stop("Specify 'request' argument or load file with 'loadGLMFile'.")        
      }
      if (!missing(parameters)) {
        ogr2ogrParams <- ""
        # -splitlistfields not needed for rgdal >= 0.9.1
        if (!is.null(parameters$splitListFields) && parameters$splitListFields)
          ogr2ogrParams <- paste(ogr2ogrParams, "-splitlistfields")
        if (!is.null(parameters$explodeCollections) && parameters$explodeCollections)
          ogr2ogrParams <- paste(ogr2ogrParams, "-explodecollections")
        if (ogr2ogrParams != "")
          convert(layer=layer, parameters=ogr2ogrParams)
      }
      response <- .private.getLayer(dataSource=cachedResponseFile, layer=layer, crs=crs, swapAxisOrder=swapAxisOrder)
      return(response)
    }
  )
)
