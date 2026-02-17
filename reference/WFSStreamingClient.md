# Streams response from a WFS

Dispatches a WFS request and parses response from the stream directly.

## See also

[`WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md),
[`WFSCachingClient`](https://ropengov.github.io/rwfs/reference/WFSCachingClient.md)

## Author

Jussi Jousimo <jvj@iki.fi>

## Super class

[`rwfs::WFSClient`](https://ropengov.github.io/rwfs/reference/WFSClient.md)
-\> `WFSStreamClient`

## Methods

### Public methods

- [`WFSStreamingClient$listLayers()`](#method-listLayers)

- [`WFSStreamingClient$getLayer()`](#method-getLayer)

- [`WFSStreamingClient$clone()`](#method-clone)

Inherited methods

- [`rwfs::WFSClient$getRaster()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-getRaster)

- [`rwfs::WFSClient$initialize()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-initialize)

- [`rwfs::WFSClient$setRequest()`](https://ropengov.github.io/rwfs/reference/WFSClient.html#method-setRequest)

------------------------------------------------------------------------

### Method `listLayers()`

#### Usage

    WFSStreamingClient$listLayers()

------------------------------------------------------------------------

### Method `getLayer()`

#### Usage

    WFSStreamingClient$getLayer(layer, ...)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSStreamingClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
