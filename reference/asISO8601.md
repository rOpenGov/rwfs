# Returns date time string in ISO8601 format

Converts an object which can be converted to a POSIXlt object to a
ISO8601 date time string.

## Usage

``` r
asISO8601(dt)
```

## Arguments

- dt:

  Date time object which can be converted to a POSIXlt object.

## Value

Character string in ISO8601 format.

## Author

Jussi Jousimo <jvj@iki.fi>

## Examples

``` r
asISO8601("2014-01-01")
#> [1] "2014-01-01T00:00:00Z"
```
