context("WFS*Client classes: inheritance, instances and methods")

source("setup.R")

# Tests -------------------------------------------------------------------

test_that("Inheriting and instantiating WFSStreamingClient works", {
  # Create a request instance
  streaming_request <- TestWFSStreamingRequest$new()
  streaming_request$getFeature(version = "1.1.0",
                               typeNames = "cities",
                               maxFeatures = 10)
  # Create the client instance
  streaming_client <- WFSStreamingClient$new(request = streaming_request)
  streaming_layers <- streaming_client$listLayers()

  streaming_response <- streaming_client$getLayer(layer = streaming_layers[1],
                                                  quiet = TRUE)
  # Manually coerce POPULATION to numeric, this is so already in the test
  # data
  streaming_response$POPULATION <- as.numeric(streaming_response$POPULATION)

  expect_is(streaming_response, "sf",
            info = "The class of response object is not 'sf'")

})

test_that("Inheriting and instantiating WFSCachingClient works", {
  # Create a request instance
  caching_request <- TestWFSCachingRequest$new()
  caching_request$getFeature(version = "1.1.0",
                             typeNames = "cities",
                             maxFeatures = 10)
  # Create the client instance
  caching_client <- WFSCachingClient$new(request = caching_request)
  caching_layers <- caching_client$listLayers()

  expect_equal(caching_layers$name, "cities", info = "Layer name not correct")
  expect_equal(caching_layers$driver, "GML", info = "Layer driver not correct")
  expect_equal(caching_layers$features, 10, info = "Layer feature # not correct")
  expect_equal(caching_layers$field, 3, info = "Layer field # not correct")
  
  caching_response <- caching_client$getLayer(layer = caching_layers[1],
                                              quiet = TRUE)

  caching_response$POPULATION <- as.numeric(caching_response$POPULATION)

  expect_is(caching_response, "sf",
            info = "The class of response object is not 'sf'")

})
