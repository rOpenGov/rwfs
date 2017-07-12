context("WFS*Client classes: inheritance, instances and methods")

source("setup.R")

# Tests -------------------------------------------------------------------

# test_that("Inheriting and instantiating WFSStreamingClient works", {  
#   # Create a request instance
#   streaming_request <- TestWFSStreamingRequest$new()
#   streaming_request$getFeature(version = "1.1.0",
#                                typeNames = "cities",
#                                maxFeatures = 10)
#   # Create the client instance
#   streaming_client <- WFSStreamingClient$new(request = streaming_request)
#   streaming_layers <- streaming_client$listLayers()
#   
#   streaming_response <- streaming_client$getLayer(layer = streaming_layers[1],
#                                                   quiet = TRUE)
#   # Manually coerce POPULATION to numeric, this is so already in the test
#   # data
#   streaming_response$POPULATION <- as.numeric(streaming_response$POPULATION)
#   
#   expect_equal(streaming_response, test_data,
#                info = "Response SpatialPointsDataFrame not what expected")
# 
# })

# test_that("Inheriting and instantiating WFSCachingClient works", {  
#   # Create a request instance
#   caching_request <- TestWFSCachingRequest$new()
#   caching_request$getFeature(version = "1.1.0",
#                              typeNames = "cities",
#                              maxFeatures = 10)
#   # Create the client instance
#   caching_client <- WFSCachingClient$new(request = caching_request)
#   caching_layers <- caching_client$listLayers()
#   
#   expect_equal(list(name = "cities", geomtype = list(""), driver = "GML", features = 10, 
#                     fields = 3), 
#                caching_layers,
#                info = "Layer structure in WFSCachingClient not correct")
#   
#   caching_response <- caching_client$getLayer(layer = caching_layers[1], 
#                                               ogr2ogr = FALSE,
#                                               parameters = list(splitListFields = TRUE),
#                                               verbose = FALSE)
#   
#   caching_response$POPULATION <- as.numeric(caching_response$POPULATION)
#   
#   expect_equal(caching_response, test_data,
#                info = "Response SpatialPointsDataFrame not what expected")
#   
# })
