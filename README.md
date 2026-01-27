
<!-- badges: start -->

[![R-CMD-check](https://github.com/anyamemensah/datadict/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/anyamemensah/datadict/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

## datadict <a href='https://github.com/anyamemensah/datadict'></a>

**datadict** is an R package that provides a clean, consistent summary
of a data frame or tibble’s structure. Through its core function,
`generate_dict()`, the package automates the extraction of variable
metadata, including names, labels, data types, and distributions (such
as unique values, value labels, and numeric ranges), producing a
standardized reference that simplifies data exploration and
documentation.

## Installation

For the latest updates, install the development version of the package
from GitHub:

``` r
remotes::install_github("anyamemensah/datadict", build_vignettes = TRUE)
```

## Learn more

Learn more about the package by browsing the [online
documentation](https://anyamemensah.github.io/datadict/) or reviewing
the introductory vignette:

``` r
vignette("datadict-intro", "datadict")
```

## Contribute to the Package

If you notice a bug or would like to make a suggestion about how to
improve the package, please [submit an
issue](https://github.com/anyamemensah/datadict/issues) or join the
discussion on a [pull
request](https://github.com/anyamemensah/datadict/pulls).
