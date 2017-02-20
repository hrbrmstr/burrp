burp_time <- function(x) {
  tmp <- gsub("[[:alnum:]]+ ([[:digit:]]{4})", "\\1", x)
  as.POSIXct(tmp, format="%a %b %d %H:%M:%S %Y")
}

#' Functional helpers
#'
#' @param x object
#' @param mimetype character
#' @export
mime_is <- function(x, mimetype) { x == mimetype }

#' @rdname mime_is
#' @param method character
#' @export
method_is <- function(x, method) { x == method }

#' @rdname mime_is
#' @param status character
#' @export
status_is <- function(x, status) { x == status }

#' @rdname mime_is
#' @param protocol character
#' @export
protocol_is <- function(x, protocol) { x == protocol }

#' @rdname mime_is
#' @param extension character
#' @export
extension_is <- function(x, extension) { x == extension }

#' @rdname mime_is
#' @param port character
#' @export
port_is <- function(x, port) { x == port }
