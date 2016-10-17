context("WFS*Client classes: inheritance, instances and methods")

source("setup.R")

# Tests -------------------------------------------------------------------

test_that("Inheriting and instantiating WFSStreamingClient works", {  
  # Create a request instance
  TestStreamingWFSRequest <- subclass_factory(WFSStreamingRequest)
  streaming_request <- TestStreamingWFSRequest$new()
  streaming_request$getFeature(version = "1.1.0",
                               typeNames = "cities",
                               maxFeatures = 10)
  # Create the client instance
  streaming_client <- WFSStreamingClient$new(request = streaming_request)
  streaming_layers <- streaming_client$listLayers()

  expect_equal(structure("cities", driver = "GML", nlayers = 1), 
               streaming_layers,
               info = "Layer structure not correct")
  
  streaming_response <- streaming_client$getLayer(layer = streaming_layers[1], 
                                                  parameters = list(splitListFields = TRUE),
                                                  verbose = FALSE)
  
  expect_equal(streaming_response, test_data,
               info = "Response SpatialPointsDataFrame not what expected")

})

test_that("Inheriting and instantiating WFSCachingClient works", {  
  # Create a request instance
  TestCachingWFSRequest <- subclass_factory(WFSCachingRequest)
  caching_request <- TestCachingWFSRequest$new()
  caching_request$getFeature(version = "1.1.0",
                             typeNames = "cities",
                             maxFeatures = 10)
  # Create the client instance
  caching_client <- WFSCachingClient$new(request = caching_request)
  caching_layers <- caching_client$listLayers()
  
  expect_equal(structure("cities", driver = "GML", nlayers = 1), 
               caching_layers,
               info = "Layer structure not correct")
  
  caching_response <- caching_client$getLayer(layer = caching_layers[1], 
                                              ogr2ogr = FALSE,
                                              parameters = list(splitListFields = TRUE),
                                              verbose = FALSE)
  
  expect_equal(caching_response, test_data,
               info = "Response SpatialPointsDataFrame not what expected")
  
})

