
`burrp` : Tools to Import and Process [PortSwigger](https://portswigger.net/) 'Burp' Proxy Data

The Burp Suite is a set of web application and security testing tools. Combined, they intercept, record and can even transform browser traffic.

For now, the solo function - `read_burp` - expects the `request` and `response` elements of a Burp XML export file to be base 64 encoded.

Eventually the `request` object will be turned into an `httr` compatible object and there will likely be and an `as_har()` function to turn the entire structure into a `HARtools` object.

To use this package you either need to have Burp proxy export files handy, use the built-in example data file or [download Burp](https://portswigger.net/burp/) and capture some web traffic and export the data.

The current Burp proxy example capture file is of a capture from the 🍊 "news survey" and was used solely out of convenience (was making sure it actually POSTed formndata). It will be subbed out for something much less depressing at some point.

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
  read_burp() -> burp_df

glimpse(burp_df)
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
    ## $ response       <list> [<https://action.trump2016.com/trump-mms-survey/, 200, Sat, 18 Feb 2017 19:56:26 GMT, text/...
    ## $ comment        <chr> "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ...

``` r
burp_df$response[[1]]
```

    ## Response [https://action.trump2016.com/trump-mms-survey/]
    ##   Date: 2017-02-18 14:56
    ##   Status: 200
    ##   Content-Type: text/html; charset=utf-8
    ##   Size: 53.2 kB
    ## 
    ## 
    ## <!DOCTYPE html>
    ## <!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
    ## <!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
    ## <!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
    ## <!--[if gt IE 8]><!-->
    ## <html lang="en"><!--<![endif]-->
    ##  <head>
    ##      <!-- Adobe Dynamic Tag -->
    ## ...

### Test Results

``` r
library(burrp)
library(testthat)

date()
```

    ## [1] "Sun Feb 19 06:49:39 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
