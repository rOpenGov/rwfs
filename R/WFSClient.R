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

#' WFS client abstract class
#' 
#' An abstract class to represent OGC's WFS.
#' 
#' @seealso \code{\link{WFSStreamingClient}}, \code{\link{WFSCachingClient}}, \code{\link{WFSRequest}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @import raster
#' @import sf
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSClient
#' @export WFSClient
WFSClient <- R6::R6Class(
  "WFSClient",
  private = list(
    request = NULL,
    
    .listLayers = function(dataSource) {
      if (missing(dataSource)) {
        stop("Required argument 'dataSource' missing.")
      }
      if (!inherits(dataSource, "character")) {
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      }
      layers <- try(sf::st_layers(dsn = dataSource)) 
      if (inherits(layers, "try-error")) {
        if (length(grep("Cannot open data source", layers)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else stop("Fatal error.")
      }
      
      return(layers)
    },
    
    .getLayer = function(dataSource, layer, ...) {
      if (missing(dataSource)) {
        stop("Required argument 'dataSource' missing.")
        }
      if (missing(layer)) {
        stop("Required argument 'layer' missing.")
      }
      if (!inherits(dataSource, "character")) {
        stop("Argument 'dataSource' must be a descendant of class 'character'.")
      }
    
      response <- try(sf::st_read(dsn = dataSource, layer = layer$name,
                                  stringsAsFactors = FALSE, ...))
      if (inherits(response, "try-error")) {
        if (length(grep("Cannot open data source", response)) == 1) {
          warning("Unable to connect to the data source or error in query result.")
          return(character(0))
        }
        else {
          stop("Fatal error.")
        }
      }
      
      return(response)
    },
    
    getRasterURL = function(parameters) {
      stop("Unimplemented method.", call. = FALSE)
    },
    
    importRaster = function(destFile) {
      raster <- raster::brick(destFile)
      return(raster)
    }
  ),
  public = list(
    initialize = function(request) {
      self$setRequest(request = request)
      return(invisible(self))
    },
    
    setRequest = function(request) {
      if (missing(request)) {
        stop("Required argument 'request' missing.")
      }
      if (!inherits(request, "WFSRequest")) {
        stop("Argument 'request' must be a descedant of class 'WFSRequest'")
      }
      private$request <- request
      return(invisible(self))
    },
    
    listLayers = function() {
      stop("Unimplemented method.", call. = FALSE)
    },
    
    getLayer = function(layer, crs = NULL, swapAxisOrder = FALSE, 
                        parameters) {
      stop("Unimplemented method.")
    },
    
    getRaster = function(parameters) {
      rasterURL <- private$getRasterURL(parameters = parameters)
      if (length(rasterURL) == 0) {
        return(character())
      }
      
      destFile <- tempfile()
      # NOTE! mode = "wb" is required on Windows.
      success <- download.file(rasterURL, destfile = destFile, 
                               method = "internal", mode = "wb")
      if (success != 0) {
        warning("Failed to download raster file.")
        return(character())
      }
      
      raster <- private$importRaster(destFile)
      return(raster)
    }
  )
)

#' @title Streams response from a WFS
#' @description Dispatches a WFS request and parses response from the stream directly.
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSCachingClient}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSStreamingClient
#' @export WFSStreamingClient
WFSStreamingClient <- R6::R6Class(
  "WFSStreamClient",
  inherit = WFSClient,
  public = list(
    listLayers = function() {
      message("Streaming layers directly from the data source\n",
              private$request$getDataSource())
      layers <- private$.listLayers(dataSource = private$request$getDataSource())
      return(layers)
    },
    
    getLayer = function(layer, ...) {
      if (missing(layer)) {
        stop("Required argument 'layer' missing.")
      }
      message("Reading layers directly from the data source\n", 
              private$request$getDataSource()) 
      response <- private$.getLayer(dataSource = private$request$getDataSource(), 
                                    layer = layer, ...)
      return(response)
    }
  )
)

#' @title Downloads response from a WFS and parses the intermediate file
#' @description Dispatches a WFS request, saves the response to a file and parses the file. The data can be converted
#' using ogr2ogr of RGDAL. Provides a caching mechanism for subsequent queries on the same data.
#' @seealso \code{\link{WFSRequest}}, \code{\link{WFSStreamingClient}}
#' @usage NULL
#' @format NULL
#' @import R6
#' @import digest
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSCachingClient
#' @export WFSCachingClient
WFSCachingClient <- R6::R6Class(
  "WFSCachingClient",
  inherit = WFSClient,
  private = list(
    cachedResponseFile = NULL,
    requestHash = NULL, # Save the hash of the request object to detect changed request
    
    cacheResponse = function() {
      if (is.null(private$cachedResponseFile) || private$requestHash != digest(private$request)) {
        destFile <- private$request$getDataSource()
        if (length(destFile) == 0) {
          return(character(0))
        }
        private$cachedResponseFile <- destFile
        private$requestHash <- digest(private$request)
      }
      return(invisible(self))
    }
  ),
  public = list(
    saveGMLFile = function(destFile) {
      "Saves cached response to a file in GML format."
      if (missing(destFile)) {
        stop("Required argument 'destFile' missing.")
      }
      if (private$cachedResponseFile == "" || !file.exists(private$cachedResponseFile)) {
        stop("Response file missing. No query has been made?")
      }
      file.copy(private$cachedResponseFile, destFile)
      return(invisible(self))
    },
    
    loadGMLFile = function(fromFile) {
      "Loads saved GML file into the object for parsing."
      if (missing(fromFile)) {
        stop("Required argument 'fromFile' missing.")
      }
      if (!file.exists(fromFile)) {
        stop("File does not exist.")
      }
      # FIXME: Woah, what's going on here?
      private$cachedResponseFile <<- fromFile
      return(invisible(self))
    },
   
    listLayers = function() {
      if (is.character(private$cacheResponse())) {
        return(character(0))
      }
      layers <- private$.listLayers(dataSource = private$cachedResponseFile)
      return(layers)
    },
    
    getLayer = function(layer, ...)  {
      
      # If a character is returned, there is no destFile
      if (is.character(private$cacheResponse())) {
        return(character(0))
      }
      # Get the path to the response file
      sourceFile <- private$cachedResponseFile
      # Use (cached) response file path as data source. 
      response <- private$.getLayer(dataSource = sourceFile, 
                                    layer = layer, ...)
      return(response)
    }
  )
)
