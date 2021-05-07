
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Submission

<!-- badges: start -->

[![Build
Status](https://travis-ci.org/larkinj/Submission.svg?branch=master)](https://travis-ci.org/larkinj/Submission)
<!-- badges: end -->

This package is published as part of the Building an R Package coursera
course.

## Installation

You can install the released version of Submission from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("Submission")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("larkinj/Submission")
```

## Example

## Package Details

The Fatality Analysis Reporting System (FARS) is a nationwide census
prepared by the US National Highway Traffic Safety Administration. It
provides the American public yearly data regarding fatal injuries
suffered in motor vehicle traffic crashes.

This package helps to use FARS data in your analysis. Filenames can be
created programmatically using the make\_filename function:

``` r
library(Submission)
farsFile <- file.path(".","inst","extdata",make_filename(2013))
```

To load a FAR file use the far\_read function:

``` r
head(fars_read(farsFile))
#> Warning: `tbl_df()` was deprecated in dplyr 1.0.0.
#> Please use `tibble::as_tibble()` instead.
#> # A tibble: 6 x 50
#>   STATE ST_CASE VE_TOTAL VE_FORMS PVH_INVL  PEDS PERNOTMVIT PERMVIT PERSONS
#>   <dbl>   <dbl>    <dbl>    <dbl>    <dbl> <dbl>      <dbl>   <dbl>   <dbl>
#> 1     1   10001        1        1        0     0          0       8       8
#> 2     1   10002        2        2        0     0          0       2       2
#> 3     1   10003        1        1        0     0          0       1       1
#> 4     1   10004        1        1        0     0          0       3       3
#> 5     1   10005        2        2        0     0          0       3       3
#> 6     1   10006        2        2        0     0          0       3       3
#> # ... with 41 more variables: COUNTY <dbl>, CITY <dbl>, DAY <dbl>, MONTH <dbl>,
#> #   YEAR <dbl>, DAY_WEEK <dbl>, HOUR <dbl>, MINUTE <dbl>, NHS <dbl>,
#> #   ROAD_FNC <dbl>, ROUTE <dbl>, TWAY_ID <chr>, TWAY_ID2 <chr>, MILEPT <dbl>,
#> #   LATITUDE <dbl>, LONGITUD <dbl>, SP_JUR <dbl>, HARM_EV <dbl>,
#> #   MAN_COLL <dbl>, RELJCT1 <dbl>, RELJCT2 <dbl>, TYP_INT <dbl>,
#> #   WRK_ZONE <dbl>, REL_ROAD <dbl>, LGT_COND <dbl>, WEATHER1 <dbl>,
#> #   WEATHER2 <dbl>, WEATHER <dbl>, SCH_BUS <dbl>, RAIL <chr>, NOT_HOUR <dbl>,
#> #   NOT_MIN <dbl>, ARR_HOUR <dbl>, ARR_MIN <dbl>, HOSP_HR <dbl>, HOSP_MN <dbl>,
#> #   CF1 <dbl>, CF2 <dbl>, CF3 <dbl>, FATALS <dbl>, DRUNK_DR <dbl>
```
