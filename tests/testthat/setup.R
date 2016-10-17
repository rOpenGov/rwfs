# Setup functions and data ------------------------------------------------

base_url <- "http://demo.mapserver.org/cgi-bin/wfs?"

subclass_factory <- function(parent_class) {
  instance <-  R6::R6Class(
    paste0("Test", parent_class$classname),
    inherit = parent_class,
    private = list(
      getURL = function() {
        # Use a public WFS (1.0.0/1.1.0) server to query world cities
        url <- paste0(base_url, private$getParametersString())
        return(url)
      }
    ),
    public = list(
      getDataSource = function() {
        return(private$getURL())
      }
    )
  )
  return(instance)
}

# Generate data agains which WFS* responses are compared. This is essentially 
# dput() output from a live query. THIS WILL BREAK if something changes
# at the data source.

test_data <- new("SpatialPointsDataFrame", 
                 data = structure(list(gml_id = c("cities.8338", "cities.1225", "cities.2616", 
                                                  "cities.9339", "cities.9181", "cities.9055", 
                                                  "cities.5102", "cities.1350", "cities.1663", 
                                                  "cities.6382"), 
                                       POPULATION = c("12116379", "10537226", "10232924", 
                                                      "10194978", "9630586", "9418987", 
                                                      "9005576", "8942250", "8827879", 
                                                      "8681360"), 
                                       NAME = c("Buenos Aires", "Karachi", "Manila", "Sao Paulo", 
                                                "Seoul", "Istanbul", "Shanghai", "Dhaka", 
                                                "Jakarta", "Mexico")), 
                                  .Names = c("gml_id", "POPULATION", "NAME"), 
                                  row.names = c(NA, -10L), class = "data.frame"), 
                 coords.nrs = numeric(0), 
                 coords = structure(c(-34.5875, 24.866667, 14.604167, -23.533333, 37.566389, 
                                      41.018611, 31.222222, 23.723056, -6.174444, 19.434167, -58.6725, 
                                      67.05, 120.982222, -46.616667, 126.999722, 28.964722, 121.458056, 
                                      90.408611, 106.829444, -99.138611), 
                                    .Dim = c(10L, 2L), 
                                    .Dimnames = list(NULL, c("coords.x1", "coords.x2"))), 
                 bbox = structure(c(-34.5875, -99.138611, 41.018611, 126.999722), 
                                  .Dim = c(2L, 2L), 
                                  .Dimnames = list(c("coords.x1", "coords.x2"), c("min", "max"))), 
                 proj4string = new("CRS", 
                                   projargs = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
)