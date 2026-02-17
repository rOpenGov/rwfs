# Class represeting a WFS client

An abstract class to represent OGC's WFS client in R. Other client
classes in this package inherit this this class.

## Format

`R6Class` object.

## Methods

- `new(request)`:

  This method is used to create object of this class with `request` as
  the request object containing WFS connection information and methods.
  NOTE: as this is abstract class, you shouldn't be creating instances
  of it.

- setRequest(request):

  Set client's request object to `request`, which must inherit from
  [`WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md).

- listLayers():

  Not implemented in this abstract class, but it classes inheriting this
  class.

- getLayer:

  Not implemented in this abstract class, but it classes inheriting this
  class.

- getRaster:

  Get a raster layer from WFS

## See also

[`WFSStreamingClient`](https://ropengov.github.io/rwfs/reference/WFSStreamingClient.md),
[`WFSCachingClient`](https://ropengov.github.io/rwfs/reference/WFSCachingClient.md),
[`WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md)

## Author

Jussi Jousimo <jvj@iki.fi>, Joona Lehtomaki <joona.lehtomaki@gmail.com>

## Public fields

- `test`:

## Active bindings

- `test`:

## Methods

### Public methods

- [`WFSClient$new()`](#method-new)

- [`WFSClient$setRequest()`](#method-setRequest)

- [`WFSClient$listLayers()`](#method-listLayers)

- [`WFSClient$getLayer()`](#method-getLayer)

- [`WFSClient$getRaster()`](#method-getRaster)

- [`WFSClient$clone()`](#method-clone)

------------------------------------------------------------------------

### Method `new()`

#### Usage

    WFSClient$new(request)

------------------------------------------------------------------------

### Method `setRequest()`

#### Usage

    WFSClient$setRequest(request)

------------------------------------------------------------------------

### Method `listLayers()`

#### Usage

    WFSClient$listLayers()

------------------------------------------------------------------------

### Method `getLayer()`

#### Usage

    WFSClient$getLayer(layer, ...)

------------------------------------------------------------------------

### Method `getRaster()`

#### Usage

    WFSClient$getRaster(parameters)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
