
`burrp` : Tools to Import and Process [PortSwigger](https://portswigger.net/) 'Burp' Proxy Data

The Burp Suite is a set of web application and security testing tools. Combined, they intercept, record and can even transform browser traffic.

For now, the solo function - `read_burp` - expects the `request` and `response` elements of a Burp XML export file to be base 64 encoded.

Eventually there will likely be an `as_har()` function to turn the entire structure into a `HARtools` object.

To use this package you either need to have Burp proxy export files handy, use the built-in example data file or [download Burp](https://portswigger.net/burp/) and capture some web traffic and export the data.

The current Burp proxy example capture file is of a capture from the :orange: "news survey" and was used solely out of convenience (was making sure it actually POSTed formndata). It will be subbed out for something much less depressing at some point.

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
    ## $ request        <list> [<GET, https://action.trump2016.com/trump-mms-survey/, action.trump2016.com, Mozilla/5.0 (M...
    ## $ status         <chr> "200", "200", "200", "200", "200", "200", "200", "200", "200", "", "", "200", "200", "", "20...
    ## $ responselength <dbl> 53953, 1210, 93988, 6515, 21669, 84091, 6713, 1890, 39936, NA, NA, 43553, 385, NA, 903, 914,...
    ## $ mimetype       <chr> "HTML", "script", "script", "script", "script", "script", "script", "script", "script", "", ...
    ## $ response       <list> [<https://action.trump2016.com/trump-mms-survey/, 200, Sat, 18 Feb 2017 19:56:26 GMT, text/...
    ## $ comment        <chr> "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ...

``` r
burp_df$response[[42]]
```

    ## Response [https://action.trump2016.com/survey/trump-mms-survey/]
    ##   Date: 2017-02-18 14:56
    ##   Status: 302
    ##   Content-Type: text/html
    ##   Size: 154 B
    ## <html>
    ## <head><title>302 Found</title></head>
    ## <body bgcolor="white">
    ## <center><h1>302 Found</h1></center>
    ## <hr><center>nginx</center>
    ## </body>
    ## </html>

``` r
burp_df$request[[42]]
```

    ## <request>
    ## POST https://action.trump2016.com/survey/trump-mms-survey/
    ## Output: list
    ## Options:
    ## * useragent: NULL
    ## * post: TRUE
    ## * postfieldsize: 247
    ## * postfields: as.raw(c(0x63, 0x73, 0x72, 0x66, 0x6d, 0x69, 0x64, 0x64, 0x6c, 0x65, 0x77, 0x61, 0x72, 0x65, 0x74, 0x6f, 0x6b, 0x65, 0x6e, 0x3d, 0x67, 0x76, 0x71, 0x36, 0x61, 0x6e, 0x32, 0x76, 0x6a, 0x49, 0x6a, 0x37, 0x56, 0x4e, 0x72, 0x38, 0x71, 0x56, 0x58, 0x73, 0x59, 0x61, 0x48, 0x35, 0x52, 0x48, 0x32, 0x4c, 0x41, 0x4e, 0x32, 0x57, 0x26, 0x66, 0x75, 0x6c, 0x6c, 0x5f, 0x6e, 0x61, 0x6d, 0x65, 0x3d, 0x45, 0x78, 0x2b, 0x41, 0x6d, 0x70, 0x6c, 0x65, 0x26, 0x66, 0x69, 0x72, 0x73, 0x74, 0x5f, 0x6e, 0x61, 0x6d, 0x65, 
    ## 0x3d, 0x45, 0x78, 0x26, 0x6c, 0x61, 0x73, 0x74, 0x5f, 0x6e, 0x61, 0x6d, 0x65, 0x3d, 0x41, 0x6d, 0x70, 0x6c, 0x65, 0x26, 0x65, 0x6d, 0x61, 0x69, 0x6c, 0x3d, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x25, 0x34, 0x30, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x26, 0x70, 0x6f, 0x73, 0x74, 0x61, 0x6c, 0x5f, 0x63, 0x6f, 0x64, 0x65, 0x3d, 0x31, 0x30, 0x31, 0x31, 0x32, 0x26, 0x73, 0x76, 0x69, 0x64, 0x3d, 0x32, 0x36, 0x30, 0x26, 0x75, 0x74, 0x6d, 0x5f, 0x73, 0x6f, 0x75, 0x72, 0x63, 
    ## 0x65, 0x3d, 0x4e, 0x41, 0x26, 0x75, 0x74, 0x6d, 0x5f, 0x6d, 0x65, 0x64, 0x69, 0x75, 0x6d, 0x3d, 0x4e, 0x41, 0x26, 0x75, 0x74, 0x6d, 0x5f, 0x63, 0x61, 0x6d, 0x70, 0x61, 0x69, 0x67, 0x6e, 0x3d, 0x4e, 0x41, 0x26, 0x75, 0x74, 0x6d, 0x5f, 0x63, 0x6f, 0x6e, 0x74, 0x65, 0x6e, 0x74, 0x3d, 0x4e, 0x41, 0x26, 0x61, 0x64, 0x5f, 0x66, 0x6c, 0x69, 0x67, 0x68, 0x74, 0x3d, 0x4e, 0x41, 0x26, 0x69, 0x6c, 0x69, 0x73, 0x74, 0x3d, 0x26, 0x70, 0x67, 0x74, 0x79, 0x70, 0x65, 0x3d, 0x4e, 0x6f, 0x6e, 0x65))
    ## Headers:
    ## * host: action.trump2016.com
    ## * user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:51.0) Gecko/20100101 Firefox/51.0
    ## * accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    ## * accept-language: en-US,en;q=0.5
    ## * referer: https://action.trump2016.com/trump-mms-survey/
    ## * cookie: __cfduid=de45b7c712d9e09399136484dfeb6b9d21487447785; csrftoken=gvq6an2vjIj7VNr8qVXsYaH5RH2LAN2W; AMCV_4B3221AA564EF52E7F000101%40AdobeOrg=-1248264605%7CMCIDTS%7C17216%7CMCMID%7C85869963419843325149068145715167308571%7CMCAID%7CNONE%7CMCOPTOUT-1487454987s%7CNONE; mbox=check#true#1487447847|session#1487447786118-518973#1487449647|PC#1487447786118-518973.17_51#1488657388; AMCVS_4B3221AA564EF52E7F000101%40AdobeOrg=1; s_cc=true; csid=403416338; __distillery=ee70bea_bd0693e8-7d09-4ca1-a3bb-e3e383878f49-289c85faf-a35ed3cb44cc-3a4d; s_fid=0DF70C89B5017746-32311BBD9287A0D2; s_sq=gopdjtlive%3D%2526c.%2526a.%2526activitymap.%2526page%253Dhttps%25253A%25252F%25252Faction.trump2016.com%25252Ftrump-mms-survey%25252F%2526link%253DSubmit%2526region%253Dsurvey-form%2526.activitymap%2526.a%2526.c
    ## * connection: close
    ## * upgrade-insecure-requests: 1
    ## * content-type: application/x-www-form-urlencoded
    ## * content-length: 247

### Test Results

``` r
library(burrp)
library(testthat)

date()
```

    ## [1] "Sun Feb 19 07:49:12 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
