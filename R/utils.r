burp_time <- function(x) {
  tmp <- gsub("[[:alnum:]]+ ([[:digit:]]{4})", "\\1", x)
  as.POSIXct(tmp, format="%a %b %d %H:%M:%S %Y")
}
