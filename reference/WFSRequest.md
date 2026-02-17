# An abstract class for referencing a WFS or a GML document

This class should be inherited and the abstract method `getDataSource`
overloaded in a subclass to provide a reference.

## See also

[`WFSClient`](https://ropengov.github.io/rwfs/reference/WFSClient.md),
[`GMLFile`](https://ropengov.github.io/rwfs/reference/GMLFile.md)

## Author

Jussi Jousimo <jvj@iki.fi>

## Methods

### Public methods

- [`WFSRequest$getDataSource()`](#method-getDataSource)

- [`WFSRequest$print()`](#method-print)

- [`WFSRequest$clone()`](#method-clone)

------------------------------------------------------------------------

### Method `getDataSource()`

#### Usage

    WFSRequest$getDataSource()

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

#### Usage

    WFSRequest$print(...)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSRequest$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
