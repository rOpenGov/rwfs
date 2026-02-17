# Downloads response from a WFS and parses the intermediate file

Dispatches a WFS request, saves the response to a file and parses the
file. The data can be converted using ogr2ogr of RGDAL. Provides a
caching mechanism for subsequent queries on the same data.

## See also

[`WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md),
[`WFSStreamingClient`](https://ropengov.github.io/rwfs/reference/WFSStreamingClient.md)

## Author

Jussi Jousimo <jvj@iki.fi>

## Super class

[`rwfs::WFSClient`](https://ropengov.github.io/rwfs/reference/WFSClient.md)
-\> `WFSCachingClient`

## Methods

### Public methods

- [`WFSCachingClient$saveGMLFile()`](#method-saveGMLFile)

- [`WFSCachingClient$loadGMLFile()`](#method-loadGMLFile)

- [`WFSCachingClient$listLayers()`](#method-listLayers)

- [`WFSCachingClient$getLayer()`](#method-getLayer)

- [`WFSCachingClient$clone()`](#method-clone)

Inherited methods

- [`rwfs::WFSClient$getRaster()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-getRaster)

- [`rwfs::WFSClient$initialize()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-initialize)

- [`rwfs::WFSClient$setRequest()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-setRequest)

------------------------------------------------------------------------

### Method `saveGMLFile()`

#### Usage

    WFSCachingClient$saveGMLFile(destFile)

------------------------------------------------------------------------

### Method `loadGMLFile()`

#### Usage

    WFSCachingClient$loadGMLFile(fromFile)

------------------------------------------------------------------------

### Method `listLayers()`

#### Usage

    WFSCachingClient$listLayers()

------------------------------------------------------------------------

### Method `getLayer()`

#### Usage

    WFSCachingClient$getLayer(layer, ...)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSCachingClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
