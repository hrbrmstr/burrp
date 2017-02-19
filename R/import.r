#' Read in a Burp proxy XML export file
#'
#' For now, this function expects the `request` and `response`
#' elements to be base 64 encoded.
#'
#' Eventually the `request` object will be turned into an `httr`
#' compatible object and there will likely be and an `as_har()`
#' function to turn the entire structure into a `HARtools` object.
#'
#' @md
#' @param burp_file path to a Burp proxy XML export file
#' @param convert_response if `TRUE`, turn the `response` record into
#'        and [httr::response] object. If the `response` record cannot
#'        be turned into an [httr::response] object a warning will
#'        be issued and the raw `response` record will be returned.
#' @return a `tibble`
#' @export
#' @examples
#' library(dplyr)
#'
#' system.file("extdata", "burp.xml", package="burrp") %>%
#'   read_burp() %>%
#'   glimpse()
read_burp <- function(burp_file, convert_response=TRUE) {

  burp_file <- normalizePath(path.expand(burp_file))

  burp <- read_xml(burp_file)

  xml_find_all(burp, ".//item") %>%
    map_df(function(x) {
      kids <- xml_children(x)
      xml_text(kids) %>%
        as.list() %>%
        setNames(xml_name(kids))
    }) %>%
    mutate(
      time=burp_time(time),
      request=map(request, base64_decode),
      response=map(response, base64_decode),
      responselength=as.numeric(responselength)
    ) -> burp_df

  if (convert_response) {
    burp_df <- mutate(burp_df, response=pmap(list(response, url, time), make_response))
  }

  burp_df

}