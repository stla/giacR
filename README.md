The ‘giacR’ package
================

*R interface to ‘Giac’*

------------------------------------------------------------------------

Giac is a general purpose symbolic algebra software. It powers the
graphical interface XCas. This package allows to execute Giac commands
in R. You can find the [documentation of Giac
here](https://www-fourier.ujf-grenoble.fr/~parisse/giac/doc/en/cascmd_en/cascmd_en.html).

## Installation

``` r
remotes::install_github("stla/giacR")
```

## Initialisation of a Giac session

The ‘chromote’ package is used to create a Giac session. If the
`find_chrome()` function of ‘chromote’ returns `NULL`, you can set the
path to the Chrome executable (or Chromium, Brave, etc) to the
environment variable `CHROMOTE_CHROME`. Or you can pass it to the the
`Giac$new` function. Since the Chrome executable is in my system path, I
can use `Sys.which("chrome")`.

``` r
library(giacR)
giac <- Giac$new(Sys.which("chrome"))
```

## Examples

### Elementary calculus

``` r
giac$execute("2 + 3/7")
## [1] "17/7=2.42857142857"
```

### Gröbner bases

``` r
giac$execute("gbasis([x^3 - 2*x*y, x^2*y - 2*y^2 + x], [x, y])")
## [1] "[x^2,x*y,2*y^2-x]"
```

### Close session

``` r
giac$close()
## [1] TRUE
```
