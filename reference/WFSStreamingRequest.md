# An abstract class for building a URL reference to a WFS

An abstract class for building a URL reference to a WFS.

## Author

Jussi Jousimo <jvj@iki.fi>

## Super class

[`rwfs::WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md)
-\> `WFSStreamingRequest`

## Methods

### Public methods

- [`WFSStreamingRequest$getParameters()`](#method-getParameters)

- [`WFSStreamingRequest$setPath()`](#method-setPath)

- [`WFSStreamingRequest$setParameters()`](#method-setParameters)

- [`WFSStreamingRequest$getCapabilities()`](#method-getCapabilities)

- [`WFSStreamingRequest$getFeature()`](#method-getFeature)

- [`WFSStreamingRequest$clone()`](#method-clone)

Inherited methods

- [`rwfs::WFSRequest$getDataSource()`](https://ropengov.github.io/rwfs/reference/WFSRequest.html#method-getDataSource)

- [`rwfs::WFSRequest$print()`](https://ropengov.github.io/rwfs/reference/WFSRequest.html#method-print)

------------------------------------------------------------------------

### Method `getParameters()`

#### Usage

    WFSStreamingRequest$getParameters()

------------------------------------------------------------------------

### Method `setPath()`

#### Usage

    WFSStreamingRequest$setPath(path)

------------------------------------------------------------------------

### Method `setParameters()`

#### Usage

    WFSStreamingRequest$setParameters(...)

------------------------------------------------------------------------

### Method `getCapabilities()`

#### Usage

    WFSStreamingRequest$getCapabilities(version = "1.0.0", ...)

------------------------------------------------------------------------

### Method `getFeature()`

#### Usage

    WFSStreamingRequest$getFeature(version = "1.0.0", typeNames, ...)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSStreamingRequest$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
