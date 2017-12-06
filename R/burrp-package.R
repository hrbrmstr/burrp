#' Tools to Import and Process 'PortSwigger' 'Burp' Proxy Data
#'
#' @name burrp
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import purrr xml2 httr anytime
#' @importFrom dplyr mutate filter select group_by count left_join ungroup
#' @importFrom openssl base64_decode
#' @importFrom tibble as_tibble
#' @importFrom stringi stri_split_fixed
#' @importFrom readr read_lines
#' @importFrom scales comma
#' @importFrom stats setNames
#' @importFrom Rcpp sourceCpp
#' @importFrom shiny runApp runExample
#' @import DT
#' @useDynLib burrp
NULL


#' Pipe operator
#'
#' @name %>%
#' @rdname pipe
#' @export
#' @importFrom magrittr %>%
NULL
