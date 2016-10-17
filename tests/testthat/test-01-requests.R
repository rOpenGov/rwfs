context("WFS*Request classes: inheritance, instances and methods")

source("setup.R")

# Tests -------------------------------------------------------------------

test_that("Inheriting and instantiating WFSStreamingRequest works", {
  TestStreamingWFSRequest <- subclass_factory(WFSStreamingRequest)
  streaming_request <- TestStreamingWFSRequest$new()
  expect_is(streaming_request, "WFSStreamingRequest",
            info = "Sub class must inherit from WFSStreamingRequest")
  
  # Set parameters for a simple query. Get the first 10 country borders
  # Compare the set parameters against known good parameters
  correct_params <- list(service = "WFS",
                         version = "1.1.0",
                         request = "GetCapabilities")
  
  streaming_request$getCapabilities(version = "1.1.0")
  
  expect_equal(correct_params, streaming_request$getParameters(),
               info = "Parameters not correctly set")
  
  # Add/change parameters
  correct_params$request <- "GetFeature"
  correct_params$typeName <- "cities"
  correct_params$maxFeatures <- 10
  
  streaming_request$getFeature(version = "1.1.0",
                               typeNames = "cities",
                               maxFeatures = 10)
  
  expect_equal(correct_params, streaming_request$getParameters(),
               info = "Parameters not correctly set")
  
})

test_that("Inheriting and instantiating WFSCachingRequest works", {  
  
  TestCachingWFSRequest <- subclass_factory(WFSCachingRequest)
  cached_request <- TestCachingWFSRequest$new()
  expect_is(cached_request, "WFSCachingRequest",
            info = "Sub class must inherit from WFSCachingRequest")
  
  # Set parameters for a simple query. Get the first 10 country borders
  # Compare the set parameters against known good parameters
  correct_params <- list(service = "WFS",
                         version = "1.1.0",
                         request = "GetCapabilities")

  cached_request$getCapabilities(version = "1.1.0")
  
  expect_equal(correct_params, cached_request$getParameters(),
               info = "Parameters not correctly set")
  
  # Add/change parameters
  correct_params$request <- "GetFeature"
  correct_params$typeName <- "cities"
  correct_params$maxFeatures <- 10
  
  cached_request$getFeature(version = "1.1.0",
                            typeNames = "cities",
                            maxFeatures = 10)
  
  expect_equal(correct_params, cached_request$getParameters(),
               info = "Parameters not correctly set")
  
  # Under WFS 2.0.0, "typeName" is "typeNames"
  correct_params$version <- "2.0.0"
  names(correct_params) <- gsub("typeName", "typeNames", names(correct_params))
  
  cached_request$getFeature(version = "2.0.0",
                            typeNames = "cities",
                            maxFeatures = 10)
  
  expect_equal(correct_params, cached_request$getParameters(),
               info = "Parameters not correctly set")
  
  # Instantiate a new cached client using the request
  #cached_client <- rwfs::WFSCachingClient$new(request = cached_request)
  #cached_layers <- cached_client$listLayers()
  #cached_response <- cached_client$getLayer(layer = cached_layers[1], ogr2ogr = TRUE,
  #                                          parameters = list(splitListFields = TRUE))
  
})
