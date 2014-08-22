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

#' @title Returns date time string in ISO8601 format
#' 
#' @description Converts an object which can be converted to a POSIXlt object to a ISO8601 date time string.
#'
#' @param dt Date time object which can be converted to a POSIXlt object.
#' @return Character string in ISO8601 format.
#' @examples asISO8601("2014-01-01")
#'
#' @author Jussi Jousimo \email{jvj@@iki.fi}
#' @export

asISO8601 <- function(dt) return(strftime(dt, "%Y-%d-%mT%H:%M:%SZ"))
