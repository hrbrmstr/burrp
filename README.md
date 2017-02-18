
`burrp` : Tools to Import and Process [PortSwigger](https://portswigger.net/) 'Burp' Proxy Data

The Burp proxy is a web application and security testing tools. It intercepts, records and can even transform browsaer traffic.

For now, the solo function - `read_burp` - expects the `request` and `response` elements of a Burp XML export file to be base 64 encoded.

Eventually the `request` and `response` objects will be turned into `httr` compatible objects and there will be and an `as_har()` function to turn the entire structure into a `HARtools` object.

The following functions are implemented:

-   `read_burp` Read in a Burp proxy XML export file

### Installation

``` r
devtools::install_github("hrbrmstr/burrp")
```

``` r
options(width=120)
```

### Usage

``` r
library(burrp)
library(dplyr)

# current verison
packageVersion("burrp")
```

    ## [1] '0.1.0'

``` r
system.file("extdata", "burp.xml", package="burrp") %>%
  read_burp() %>%
  glimpse()
```

    ## Observations: 132
    ## Variables: 14
    ## $ time           <dttm> 2017-02-18 14:56:24, 2017-02-18 14:56:25, 2017-02-18 14:56:25, 2017-02-18 14:56:25, 2017-02...
    ## $ url            <chr> "https://action.trump2016.com/trump-mms-survey/", "https://wurfl.io/wurfl.js", "https://asse...
    ## $ host           <chr> "action.trump2016.com", "wurfl.io", "assets.adobedtm.com", "prod-cdn-static.gop.com", "prod-...
    ## $ port           <chr> "443", "443", "443", "443", "443", "443", "443", "443", "443", "443", "443", "443", "443", "...
    ## $ protocol       <chr> "https", "https", "https", "https", "https", "https", "https", "https", "https", "https", "h...
    ## $ method         <chr> "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "GET", "...
    ## $ path           <chr> "/trump-mms-survey/", "/wurfl.js", "/ccb66fd3556ba80512894ddaac0f1024ce58d90d/satelliteLib-8...
    ## $ extension      <chr> "null", "js", "js", "js", "js", "js", "js", "js", "js", "js", "null", "js", "null", "null", ...
    ## $ request        <list> [<47, 45, 54, 20, 2f, 74, 72, 75, 6d, 70, 2d, 6d, 6d, 73, 2d, 73, 75, 72, 76, 65, 79, 2f, 2...
    ## $ status         <chr> "200", "200", "200", "200", "200", "200", "200", "200", "200", "", "", "200", "200", "", "20...
    ## $ responselength <dbl> 53953, 1210, 93988, 6515, 21669, 84091, 6713, 1890, 39936, NA, NA, 43553, 385, NA, 903, 914,...
    ## $ mimetype       <chr> "HTML", "script", "script", "script", "script", "script", "script", "script", "script", "", ...
    ## $ response       <list> [<48, 54, 54, 50, 2f, 31, 2e, 31, 20, 32, 30, 30, 20, 4f, 4b, 0d, 0a, 44, 61, 74, 65, 3a, 2...
    ## $ comment        <chr> "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ...

### Test Results

``` r
library(burrp)
library(testthat)

date()
```

    ## [1] "Sat Feb 18 15:52:18 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
