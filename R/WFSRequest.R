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

#' @title An abstract class to build WFS request URL's
#'
#' @description This class should be inherited and the abstract method \code{getURL} overloaded to provide WFS request URL's.
#'
#' @seealso \code{\link{WFSStreamClient}}, \code{\link{WFSFileClient}}
#' @aliases getURL
#'
#' @import methods
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @exportClass WFSRequest
#' @export WFSRequest
WFSRequest <- R6Class(
  "WFSRequest",
  private = list(
    path = "list",
    parameters = "list"
  ),
  public = list(
    setPath = function(path) {
      "Sets WFS request URL path."
      private$path <- path
      return(invisible(self))
    },
    
    setParameters = function(...) {
      "Sets WFS request URL parameters."
      private$parameters <- list(...)
      return(invisible(self))
    },
    
    getPathString = function() {
      "Returns WFS request URL path as a string."
      if (length(private$path) == 0) return("")
      p <- paste(private$path, collapse="/")
      return(p)
    },
    
    getParametersString = function() {
      "Returns WFS request URL parameters as a string."
      if (length(private$parameters) == 0) return("")
      x <- lapply(seq_along(private$parameters),
                  function(i) paste(names(private$parameters)[[i]], private$parameters[[i]], sep="="))
      p <- paste(x, collapse="&")
      return(p)
    },
    
    getURL = function() {
      "Returns WFS request URL."
      stop("Must be implemented by subclass.", call.=FALSE)
    },
    
    getStreamURL = function() {
      return(paste0("WFS:", self$getURL()))
    },
    
    print = function(...) {
      cat(self$getURL(), "\n")
      return(invisible(self))
    }
  )
)
