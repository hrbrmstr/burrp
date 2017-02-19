#' Tools to Import and Process 'PortSwigger' 'Burp' Proxy Data
#'
#' @name burrp
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import anytime
#' @import purrr xml2 httr
#' @importFrom dplyr mutate
#' @importFrom openssl base64_decode
#' @importFrom tibble as_tibble
#' @importFrom stringi stri_split_fixed
#' @importFrom readr read_lines
#' @import stats
#' @useDynLib burrp
#' @importFrom Rcpp sourceCpp
NULL


#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @export
#' @importFrom magrittr %>%
NULL
