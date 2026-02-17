# An abstract class for building a URL reference to a WFS with a caching

The abstract method `getURL` must be overloaded in a subclass to provide
a request URL to a WFS service.

## Author

Jussi Jousimo <jvj@iki.fi>

## Super classes

[`rwfs::WFSRequest`](https://ropengov.github.io/rwfs/reference/WFSRequest.md)
-\>
[`rwfs::WFSStreamingRequest`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.md)
-\> `WFSCachingRequest`

## Methods

### Public methods

- [`WFSCachingRequest$getDataSource()`](#method-getDataSource)

- [`WFSCachingRequest$clone()`](#method-clone)

Inherited methods

- [`rwfs::WFSRequest$print()`](https://ropengov.github.io/rwfs/reference/WFSRequest.html#method-print)

- [`rwfs::WFSStreamingRequest$getCapabilities()`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.html#method-getCapabilities)

- [`rwfs::WFSStreamingRequest$getFeature()`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.html#method-getFeature)

- [`rwfs::WFSStreamingRequest$getParameters()`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.html#method-getParameters)

- [`rwfs::WFSStreamingRequest$setParameters()`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.html#method-setParameters)

- [`rwfs::WFSStreamingRequest$setPath()`](https://ropengov.github.io/rwfs/reference/WFSStreamingRequest.html#method-setPath)

------------------------------------------------------------------------

### Method `getDataSource()`

#### Usage

    WFSCachingRequest$getDataSource()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSCachingRequest$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
