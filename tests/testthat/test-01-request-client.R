context("WFSRequest and WFSClient inheritance")

test_that("Setting up a caching client", {  

  # Use a public WFS (1.1.0) server to query the country borders of the 
  # world (data from Natural Earth)
  TestCachingWFSRequest <- R6::R6Class(
    "TestCachingWFSRequest",
    inherit = rwfs::WFSCachingRequest,
    private = list(
      getURL = function() {
        url <- paste0("http://demo.opengeo.org/geoserver/wfs?", 
                      private$getParametersString())
        return(url)
      }
    )
  )
  
  TestStreamingWFSRequest <- R6::R6Class(
    "TestStreamingWFSRequest",
    private = list(
    inherit = rwfs::WFSStreamingRequest,
      getURL = function() {
        url <- paste0("http://demo.opengeo.org/geoserver/wfs?", 
                      private$getParametersString())
        return(url)
      }
    )
  )
  
  # Instantiate a new TestWFSRequest object
  cached_request <- TestCachingWFSRequest$new()
  # Set parameters for a simple query. Get the first 10 country borders
  cached_request$getFeature(version = "1.1.0",
                            typeNames = "ne:ne_10m_admin_0_countries",
                            maxFeatures = 10)
  
  # Instantiate a new cached client using the request
  cached_client <- rwfs::WFSCachingClient$new(request = cached_request)
  #cached_layers <- cached_client$listLayers()
  #cached_response <- cached_client$getLayer(layer = cached_layers[1], 
  #                                          parameters = list(splitListFields = TRUE))
  
  stream_request <- TestStreamingWFSRequest$new()
  # Set parameters for a simple query. Get the first 10 country borders
  #stream_request$getFeature(version = "1.1.0",
  #                          typeNames = "ne:ne_10m_admin_0_countries",
  #                          maxFeatures = 10)
  
  #stream_client <- rwfs::WFSStreamingClient$new(request = stream_request)
  #stream_layers <- stream_client$listLayers()
  #stream_response <- stream_client$getLayer(layer = stream_layers[1], 
  #                                          parameters = list(splitListFields = TRUE))
})
